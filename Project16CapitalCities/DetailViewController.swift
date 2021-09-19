//
//  DetailViewController.swift
//  Project16CapitalCities
//
//  Created by Tai Chin Huang on 2021/9/19.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var capital: Capital?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wikipedia"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let capitalTitle = capital?.title else { return }
        
        guard let url = URL(string: "https://en.wikipedia.org/wiki/\(capitalTitle)") else {
            fatalError("Load wiki fail")
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}
