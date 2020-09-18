//
//  ArticlesTableViewCell.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit
import RealmSwift

class ArticlesTableViewCell: UITableViewCell {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var articleURL = ""
    let realm = try! Realm()
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func favoritesTapped(_ sender: UIButton) {
        
        let predicate = NSPredicate(format: "title == %@", argumentArray: [titleLabel.text as Any])
        let favorites = realm.objects(FavoritesModel.self).filter(predicate)
        if let favorite = favorites.first {
            
            try! self.realm.write {
                self.realm.delete(favorite)
            }
            
        } else {
            
            let newObjectFavorites = FavoritesModel()
            newObjectFavorites.title = titleLabel.text!
            newObjectFavorites.byline = authorLabel.text!
            newObjectFavorites.publishedDate = dateLabel.text!
            newObjectFavorites.isFavorite = "star.fill"
            if let data = articleImage.image?.pngData() {
                newObjectFavorites.image = data
            }
            LocalManager.shared.getDataHTML(url: articleURL, responseDataTipe: .html) { (stringHTML) in
                guard let stringHTML = stringHTML else { return }
                newObjectFavorites.url = stringHTML
                
                try! self.realm.write {
                    self.realm.add(newObjectFavorites)
                    sender.imageView?.image = UIImage(systemName: "star.fill")
                }
            }
        }
        
    }
    
    func setupWith(currentNews: CurrentNews, isFavorite: String, image: UIImage?) {
        self.titleLabel.text = currentNews.title
        self.authorLabel.text = currentNews.byline
        self.dateLabel.text = currentNews.publishedDate
        self.articleURL = currentNews.url
        self.favoritesButton.imageView?.image = UIImage(systemName: isFavorite)
        self.articleImage.image = image
    }

}
