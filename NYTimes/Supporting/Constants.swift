//
//  Constants.swift
//  NYTimes
//
//  Created by Alex on 17.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()
let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/"
let keyAPI = "xYxWupVlGMj7djARPfqGsQlV0kQpx4hQ"

enum ResponseDataType {
    case json
    case html
    case image
}
