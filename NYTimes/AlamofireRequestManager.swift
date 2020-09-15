//
//  AlamofireRequestManager.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequest {
    func sendRequest(url: String, completion: @escaping (_ modelNews: ModelNews) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                guard let data = response.data else { return }
                
                do {
                    let result = try JSONDecoder().decode(ModelNews.self, from: data)
                    completion(result)
                    
                } catch let error as NSError {
                    print("Error: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

