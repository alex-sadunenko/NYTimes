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
    var newsArray: ModelNews?
    let alamofireRequest = AlamofireRequest()
    let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/"
    let keyAPI = "xYxWupVlGMj7djARPfqGsQlV0kQpx4hQ"
    
    var items: Results<FavoritesModel>!
    let realm = try! Realm()

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
                detailVC.articleURLOffline = items[numberSection].url
            } else {
                guard let newsArray = newsArray, let results = newsArray.results else { return }
                detailVC.articleURL = results[numberSection].url
            }
        }
    }
    
}

//MARK: - Fetch Data
extension ArticlesViewController {
    
    func dataFetch() {
        showSpinner()
        if endpointArticle != nil {
            alamofireRequest.sendRequest(url: baseURL + endpointArticle! + "api-key=" + keyAPI) { (modelNews) in
                DispatchQueue.main.async {
                    self.newsArray = modelNews
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            }
        } else {
            items = realm.objects(FavoritesModel.self)
            removeSpinner()
        }
    }
}

//MARK: - Table View Delegate
extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK: - Table View Data Source
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if endpointArticle == nil, let items = items {
            return items.count
        }
        guard let newsArray = newsArray, let results = newsArray.results else { return 0}
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if endpointArticle == nil, let items = items {
            let predicate = NSPredicate(format: "title == %@", argumentArray: [items[indexPath.row].title as Any])
            let favorites = realm.objects(FavoritesModel.self).filter(predicate)
            print(favorites)
            guard let favorite = favorites.first else { return cell}
            let image = UIImage(data: favorite.image)

            cell.setupWith(titleLabel: favorite.title, authorLabel: favorite.byline, dateLabel: favorite.publishedDate, articleImage: nil, articleURL: favorite.url, isFavorite: favorite.isFavorite, image: image)
            
        } else {
            guard let newsArray = newsArray, let results = newsArray.results else { return cell}
            let result = results[indexPath.row]
            
            let predicate = NSPredicate(format: "title == %@", argumentArray: [result.title as Any])
            let favorites = realm.objects(FavoritesModel.self).filter(predicate)
            var isFavorite = "star"
            if let favorite = favorites.first {
                isFavorite = favorite.isFavorite
            }
            
            cell.setupWith(titleLabel: result.title, authorLabel: result.byline, dateLabel: result.publishedDate, articleImage: nil, articleURL: result.url, isFavorite: isFavorite, image: UIImage())
            
            guard let media = results[indexPath.row].media.first else { return cell }
            guard let mediaMetadata = media.mediaMetadata.last else { return cell }
            guard let lastUrl = mediaMetadata.url else { return cell }
            alamofireRequest.sendRequestImage(url: lastUrl, completion: { (articleImage) in
                if let articleImage = articleImage {
                    cell.articleImage.image = articleImage
                }
            })
        }

        return cell
    }
    
}
