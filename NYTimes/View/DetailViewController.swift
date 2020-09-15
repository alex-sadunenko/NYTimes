//
//  DetailViewController.swift
//  NYTimes
//
//  Created by Alex on 15.09.2020.
//  Copyright © 2020 Alex Sadunenko. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var articleURL: String?
    var articleURLOffline: String?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if articleURL != nil {
            guard let url = URL(string: articleURL!) else { return }
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        } else if articleURLOffline != nil {
            guard let urlString = articleURLOffline else { return }
            webView.navigationDelegate = self
            webView.loadHTMLString(urlString, baseURL: nil)
        }
    }
    
}
