//
//  ArticlesViewController.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {

    var endpointArticle: String?
    var newsArray: ModelNews?
    let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/"
    let keyAPI = "xYxWupVlGMj7djARPfqGsQlV0kQpx4hQ"
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFetch()

    }
    
}

//MARK: - Fetch Data
extension ArticlesViewController {
    
    func dataFetch() {
        if endpointArticle != nil {
            let alamofireRequest = AlamofireRequest()
            alamofireRequest.sendRequest(url: baseURL + endpointArticle! + "api-key=" + keyAPI) { (modelNews) in
                DispatchQueue.main.async {
                    self.newsArray = modelNews
                    self.tableView.reloadData()
                }
            }
        } else {
            // favorites
        }
    }
}

//MARK: - Table View Data Source
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let newsArray = newsArray, let results = newsArray.results else { return 0}
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        guard let newsArray = newsArray, let results = newsArray.results else { return cell}
        cell.textLabel?.text = results[indexPath.row].title
        return cell
    }
    
}
