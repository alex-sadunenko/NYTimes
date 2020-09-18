//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Alex on 17.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
      
    static func fetchData(url: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                completion(data)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

