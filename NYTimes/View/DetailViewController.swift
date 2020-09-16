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
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSpinner()
        if articleURL != nil {
            guard let url = URL(string: articleURL!) else { return }
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        } else if articleURLOffline != nil {
            guard let urlString = articleURLOffline else { return }
            webView.navigationDelegate = self
            webView.loadHTMLString(urlString, baseURL: nil)
        }
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress == 1.0 {
                removeSpinner()
            }
        }
    }
}


