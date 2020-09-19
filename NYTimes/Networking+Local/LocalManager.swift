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
    
    public func getData(url: String, responseDataType: ResponseDataType,  completion: @escaping (Any) -> ()) {
        NetworkManager.fetchData(url: url, responseDataType: responseDataType) { (data) in
            do {
                switch responseDataType {
                case .json:
                    let result = try JSONDecoder().decode(NewsModel.self, from: data)
                    completion(result)
                case .html:
                    let result = String(data: data, encoding: .utf8)
                    completion(result as Any)
                case .image:
                    completion(data as Any)
                }
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }

}

