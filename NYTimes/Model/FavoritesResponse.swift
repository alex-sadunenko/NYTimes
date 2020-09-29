//
//  FavoritesResponse.swift
//  NYTimes
//
//  Created by Alex on 19.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import RealmSwift

struct FavoritesResponse {
    
    let favorites: [News]
    
    init(withFavorites: Results<FavoritesModel>) {
        var favorites = [News]()
        for item in withFavorites {
            let newsObject = News(withFavorites: item)
            favorites.append(newsObject)
        }
        self.favorites = favorites
    }
}
