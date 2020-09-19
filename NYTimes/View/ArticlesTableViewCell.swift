//
//  ArticlesTableViewCell.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var currentNews: News!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func favoritesTapped(_ sender: UIButton) {
        if currentNews.isFavorite {
            RealmManager.deleteObject(filterString: currentNews.title)
            sender.imageView?.image = UIImage(systemName: "star")
        } else {
            RealmManager.addFavorites(favorite: currentNews)
            sender.imageView?.image = UIImage(systemName: "star.fill")
        }
    }
    
    func setupWith(currentNews: News) {
        self.titleLabel.text = currentNews.title
        self.authorLabel.text = currentNews.byline
        self.dateLabel.text = currentNews.publishedDate
        self.favoritesButton.imageView?.image = UIImage(systemName: currentNews.isFavorite ? "star.fill" : "star")
        self.articleImage.image = UIImage(data: currentNews.image!)
        self.currentNews = currentNews
    }

}
