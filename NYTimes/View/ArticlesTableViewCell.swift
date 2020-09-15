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
    let alamofireRequest = AlamofireRequest()
        
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
            alamofireRequest.sendRequestHTML(url: articleURL) { (stringHTML) in
                guard let stringHTML = stringHTML else { return }
                newObjectFavorites.url = stringHTML
                
                try! self.realm.write {
                    self.realm.add(newObjectFavorites)
                    sender.imageView?.image = UIImage(systemName: "star.fill")
                }
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupWith(titleLabel: String?,
                   authorLabel: String?,
                   dateLabel: String?,
                   articleImage: UIImage?,
                   articleURL: String?,
                   isFavorite: String,
                   image: UIImage?) {
        self.titleLabel.text = titleLabel
        self.authorLabel.text = authorLabel
        self.dateLabel.text = dateLabel
        self.articleImage.image = articleImage
        self.articleURL = articleURL!
        self.favoritesButton.imageView?.image = UIImage(systemName: isFavorite)
        self.articleImage.image = image
    }

}
