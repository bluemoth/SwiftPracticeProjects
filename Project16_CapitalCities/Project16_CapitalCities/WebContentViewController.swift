//
//  WebContentViewController.swift
//  Project16_CapitalCities
//
//  Created by Jacob Case on 3/1/22.
//

import UIKit
import WebKit

class WebContentViewController: UIViewController, WKNavigationDelegate {

    var place: String = ""
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        openPage(place)
    }
    
    func openPage(_ place: String) {
        
        let url = URL(string: "https://en.wikipedia.org/wiki/" + place)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
