//
//  DetailViewController.swift
//  blog 2
//
//  Created by Halik Magomedov on 10/19/16.
//  Copyright © 2016 Haliks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var webview: UIWebView!

    func configureView() {
        
        if let detail = self.detailItem {
            
            self.title = detail.value(forKey: "title") as! String
                
                if let blogWebView = self.webview {
                blogWebView.loadHTMLString(detail.value(forKey: "content") as! String, baseURL: nil)
            
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

