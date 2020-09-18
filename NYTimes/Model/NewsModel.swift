//
//  NewsModel.swift
//  NYTimes
//
//  Created by Alex on 17.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct NewsModel: Decodable {
    let results: [NewsArray]?
}

struct NewsArray: Decodable {
    let url: String?
    let title: String?
    let publishedDate: String?
    let byline: String?
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case publishedDate = "published_date"
        case byline
        case media
    }
}

struct Media: Decodable {
    let mediaMetadata: [Image]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct Image: Decodable {
    let url: String?
}
