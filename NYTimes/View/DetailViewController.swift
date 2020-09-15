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
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: articleURL!) else { return }

        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
}
