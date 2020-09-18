//
//  CurrentNews.swift
//  NYTimes
//
//  Created by Alex on 17.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct CurrentNews {
    let url: String
    let title: String
    let publishedDate: String
    let byline: String
    let isFavorite: String
    let image: String
    
    init(withNews: NewsArray) {
        url = withNews.url!
        title = withNews.title!
        publishedDate = withNews.publishedDate!
        byline = withNews.byline!
        isFavorite = ""
        image = ""
    }
    
    init(withFavorites: FavoritesModel) {
        url = withFavorites.url
        title = withFavorites.title
        publishedDate = withFavorites.publishedDate
        byline = withFavorites.byline
        isFavorite = ""
        image = ""

    }
}
