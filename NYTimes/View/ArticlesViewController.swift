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
    var newsArray: NewsModel?
    var listOfNews: Results<FavoritesModel>!
    
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
                detailVC.articleURLOffline = listOfNews[numberSection].url
            } else {
                guard let newsArray = newsArray, let listOfNews = newsArray.results else { return }
                detailVC.articleURL = listOfNews[numberSection].url
            }
        }
    }
    
}

//MARK: - Fetch Data
extension ArticlesViewController {
    
    func dataFetch() {
        showSpinner()
        if endpointArticle != nil {
            LocalManager.shared.getDataJSON(url: baseURL + endpointArticle! + "api-key=" + keyAPI, responseDataTipe: .json) { (newsModel) in
                DispatchQueue.main.async {
                    self.newsArray = newsModel
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }
        } else {
            listOfNews = realm.objects(FavoritesModel.self)
            removeSpinner()
        }
    }
}

//MARK: - Table View Data Source
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if endpointArticle == nil, let listOfNews = listOfNews {
            return listOfNews.count
        }
        guard let newsArray = newsArray, let listOfNews = newsArray.results else { return 0}
        return listOfNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if endpointArticle == nil, let listOfNews = listOfNews {
            
            let predicate = NSPredicate(format: "title == %@", argumentArray: [listOfNews[indexPath.row].title as Any])
            let listOfFavorites = realm.objects(FavoritesModel.self).filter(predicate)
            guard let favorite = listOfFavorites.first else { return cell }
            let image = UIImage(data: favorite.image)

            cell.setupWith(currentNews: CurrentNews(withFavorites: favorite), isFavorite: favorite.isFavorite, image: image)
            
        } else {
            
            guard let listOfNews = newsArray?.results else { return cell}
            let currentNews = CurrentNews(withNews: listOfNews[indexPath.row])
            
            let predicate = NSPredicate(format: "title == %@", argumentArray: [currentNews.title as Any])
            let listOfFavorites = realm.objects(FavoritesModel.self).filter(predicate)
            var isFavorite = "star"
            if let favorite = listOfFavorites.first {
                isFavorite = favorite.isFavorite
            }
            
            cell.setupWith(currentNews: currentNews, isFavorite: isFavorite, image: UIImage())
            
            guard let media = listOfNews[indexPath.row].media.first else { return cell }
            guard let mediaMetadata = media.mediaMetadata.last else { return cell }
            guard let lastUrl = mediaMetadata.url else { return cell }
            LocalManager.shared.getDataImage(url: lastUrl, responseDataTipe: .image, completion: { (articleImage) in
                if let articleImage = articleImage {
                    cell.articleImage.image = articleImage
                }
            })
        }

        return cell
    }
    
}
