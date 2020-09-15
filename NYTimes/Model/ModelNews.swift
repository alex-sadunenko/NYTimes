//
//  ModelNews.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct ModelNews: Decodable {
    let results: [Results]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Results: Decodable {
    let url: String?
    let title: String?
    let publishedDate: String?
    let byline: String?
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case title = "title"
        case publishedDate = "published_date"
        case byline = "byline"
        case media = "media"
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
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
