//
//  NetworkError.swift
//  NYTimes
//
//  Created by Alex on 18.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failInternetError
    case noInternetConnection
}
