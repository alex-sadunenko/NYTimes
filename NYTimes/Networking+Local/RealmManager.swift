//
//  RealmManager.swift
//  NYTimes
//
//  Created by Alex on 19.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
        
    static func getObjects(completion: @escaping (Results<FavoritesModel>) -> ()) {
        let favorites = realm.objects(FavoritesModel.self)
        completion(favorites)
    }
    
    static func deleteObject(filterString: String) {
        let predicate = NSPredicate(format: "title == %@", argumentArray: [filterString as Any])
        let favorites = realm.objects(FavoritesModel.self).filter(predicate)
        if let favorite = favorites.first {
            try! realm.write {
                realm.delete(favorite)
            }
        }
    }
     
    static func addFavorites(favorite: News) {
        let newObjectFavorites = FavoritesModel()
        newObjectFavorites.title = favorite.title
        newObjectFavorites.byline = favorite.byline
        newObjectFavorites.publishedDate = favorite.publishedDate
        newObjectFavorites.isFavorite = true
        newObjectFavorites.image = favorite.image!
        LocalManager.shared.getData(url: favorite.url, responseDataType: .html) { (stringHTML) in
            let stringHTML = stringHTML as! String
            
            DispatchQueue.main.async {
                newObjectFavorites.url = stringHTML
                try! realm.write {
                    realm.add(newObjectFavorites)
                }

            }
        }
    }
    
}
