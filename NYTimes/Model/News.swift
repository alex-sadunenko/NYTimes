//
//  News.swift
//  NYTimes
//
//  Created by Alex on 19.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct News {
    
    let url: String
    let title: String
    let publishedDate: String
    let byline: String
    var isFavorite: Bool
    let imageUrl: String?
    var image: Data?

    init(withNews: NewsArray) {
        url = withNews.url!
        title = withNews.title!
        publishedDate = withNews.publishedDate!
        byline = withNews.byline!
        isFavorite = false
        imageUrl = withNews.media.first?.mediaMetadata.last?.url
        image = Data()
    }
    
    init(withFavorites: FavoritesModel) {
        url = withFavorites.url
        title = withFavorites.title
        publishedDate = withFavorites.publishedDate
        byline = withFavorites.byline
        isFavorite = true
        image = withFavorites.image
        imageUrl = withFavorites.imageUrl
    }
    
}
