//
//  FavoritesModel.swift
//  NYTimes
//
//  Created by Alex on 15.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import RealmSwift

class FavoritesModel: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    @objc dynamic var publishedDate = ""
    @objc dynamic var byline = ""
    @objc dynamic var isFavorite = ""
}
