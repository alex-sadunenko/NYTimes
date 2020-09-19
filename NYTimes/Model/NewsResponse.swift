//
//  NewsResponse.swift
//  NYTimes
//
//  Created by Alex on 19.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation

struct NewsResponse {
    
    let news: [News]
    
    init(withNews: NewsModel) {
        var news = [News]()
        if let newsArray = withNews.results {
            for item in newsArray {
                let newsObject = News(withNews: item)
                news.append(newsObject)
            }
        }
        self.news = news
    }
}
