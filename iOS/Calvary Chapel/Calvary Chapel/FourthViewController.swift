//
//  FourthViewController.swift
//  Calvary Chapel - Donations
//
//  Created by Kevin Stine on 1/11/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    
    @IBOutlet var donateView: UIWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let donateURL = "https://www.calvarycorvallis.org/give/"
        
       donateView.loadHTMLString("<iframe width=\(donateView.frame.width)\" height=\"\(donateView.frame.height)\" src=\"\(donateURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
       
     /*
        let myProjectBundle:Bundle = Bundle.main;
        let filePath:String = myProjectBundle.path(forResource: "donateHTML", ofType: "html")!
        
        let myURL = NSURL(string: filePath);
        let myURLRequest:NSURLRequest = NSURLRequest(url: myURL as! URL);
        
        donateView.loadRequest(myURLRequest as URLRequest)
       */

        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* -  (void)webViewDidFinishLoad:(UIWebView *)donateView {
    [webView stringByEvaluatingJavaScriptFromString:@"$document.ready(function() { $('header').remove(); })"]
    }
*/
    
}

