//
//  ArticlesViewController.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit
import RealmSwift

class ArticlesViewController: UIViewController {

    var titleSection: String?
    var endpointArticle: String?
    var news = [News]()
    var favorites = [News]()
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titleSection
        dataFetch()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailArticle" {
            let detailVC = segue.destination as! DetailViewController
            guard let numberSection = tableView.indexPathForSelectedRow?.row else { return }
            if endpointArticle == nil {
                detailVC.articleURLOffline = favorites[numberSection].url
            } else {
                detailVC.articleURL = news[numberSection].url
            }
        }
    }
    
}

//MARK: - Fetch Data
extension ArticlesViewController {
    
    func dataFetch() {
        showSpinner()
        if endpointArticle != nil {
            LocalManager.shared.getData(url: baseURL + endpointArticle! + "api-key=" + keyAPI, responseDataType: .json) { (newsModel) in
                DispatchQueue.main.async {
                    let newsResponse = NewsResponse.init(withNews: newsModel as! NewsModel)
                    self.news = newsResponse.news
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }
        } else {
            RealmManager.getObjects(completion: { (favorites) in
                let favoritesResponse = FavoritesResponse.init(withFavorites: favorites)
                self.favorites = favoritesResponse.favorites
            })
            removeSpinner()
        }
    }
}

//MARK: - Table View Data Source
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if endpointArticle == nil {
            return favorites.count
        } else {
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentNews: News
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if endpointArticle == nil {
            
            currentNews = favorites[indexPath.row]
            cell.currentNews = currentNews
            cell.setupWith(currentNews: currentNews)
            
        } else {
            
            currentNews = news[indexPath.row]
            
            let predicate = NSPredicate(format: "title == %@", argumentArray: [currentNews.title as Any])
            RealmManager.getObjects { (favoritesModel) in
                let listOfFavorites = favoritesModel.filter(predicate)
                var isFavorite = false
                if let favorite = listOfFavorites.first {
                    isFavorite = favorite.isFavorite
                }
                currentNews.isFavorite = isFavorite
            }

            
            if let imageUrl = currentNews.imageUrl {
                DispatchQueue.main.async {
                LocalManager.shared.getData(url: imageUrl, responseDataType: .image, completion: { (image) in
                    currentNews.image = image as? Data
                })
                }
            }
            cell.currentNews = currentNews

            cell.setupWith(currentNews: currentNews)
            
        }

        return cell
    }
    
}
