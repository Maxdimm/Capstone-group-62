//
//  FifthViewController.swift
//  Calvary Chapel - Messages
//
//  Created by Kevin Stine on 1/11/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    
    @IBOutlet var videoViewer: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let youtubeURL = "https://www.youtube.com/embed/K0ibBPhiaG0"
        
        videoViewer.allowsInlineMediaPlayback = true
        
        videoViewer.loadHTMLString("<iframe width=\(videoViewer.frame.width)\" height=\"\(videoViewer.frame.height)\" src=\"\(youtubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


