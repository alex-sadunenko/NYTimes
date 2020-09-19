//
//  MainViewController.swift
//  NYTimes
//
//  Created by Alex on 14.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Constants
    let listOfSections = ["Most emailed", "Most shared", "Most viewed", "Favorites"]
    let urlOfSections = ["emailed/30.json?", "shared/30.json?", "viewed/30.json?", nil]

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    //MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArticlesVC" {
            let articlesVC = segue.destination as! ArticlesViewController
            guard let numberSection = tableView.indexPathForSelectedRow?.row else { return }
            
            articlesVC.endpointArticle = urlOfSections[numberSection]
            articlesVC.titleSection = listOfSections[numberSection]
        }
    }

}

//MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Table View Data Source
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.sectionLabel.text = listOfSections[indexPath.row]
        return cell
    }
    
}
