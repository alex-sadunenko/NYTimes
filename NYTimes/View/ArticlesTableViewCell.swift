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
        print("Press favorite")
        let newObjectFavorites = FavoritesModel()
        newObjectFavorites.title = titleLabel.text!
        newObjectFavorites.byline = authorLabel.text!
        newObjectFavorites.publishedDate = dateLabel.text!
        newObjectFavorites.url = articleURL
        newObjectFavorites.isFavorite = "star.fill"
        
        try! realm.write {
            realm.add(newObjectFavorites)
            favoritesButton.imageView?.image = UIImage(systemName: "star.fill")
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
                   isFavorite: String) {
        self.titleLabel.text = titleLabel
        self.authorLabel.text = authorLabel
        self.dateLabel.text = dateLabel
        self.articleImage.image = articleImage
        self.articleURL = articleURL!
        self.favoritesButton.imageView?.image = UIImage(systemName: isFavorite)
    }

}
