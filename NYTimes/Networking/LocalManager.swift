//
//  LocalManager.swift
//  NYTimes
//
//  Created by Alex on 18.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import UIKit

class LocalManager {
    
    private init() {}
    static let shared = LocalManager()
    
    public func getDataJSON(url: String, responseDataTipe: ResponseDataType,  completion: @escaping (_ newsModel: NewsModel) -> ()) {
        NetworkManager.fetchData(url: url) { (data) in
            do {
                let result = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(result)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
    public func getDataImage(url: String, responseDataTipe: ResponseDataType,  completion: @escaping (_ articleImage: UIImage?) -> ()) {
        NetworkManager.fetchData(url: url) { (data) in
            let result = UIImage(data: data)
            completion(result)
        }
    }
    
    public func getDataHTML(url: String, responseDataTipe: ResponseDataType,  completion: @escaping (_ stringHTML: String?) -> ()) {
        NetworkManager.fetchData(url: url) { (data) in
            let result = String(data: data, encoding: .utf8)
            completion(result)
        }
    }

}

