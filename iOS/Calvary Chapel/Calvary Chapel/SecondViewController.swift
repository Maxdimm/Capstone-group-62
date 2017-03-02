//
//  SecondViewController.swift
//  Calvary Chapel - Bulletin
//
//  Created by Kevin Stine on 1/11/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIWebViewDelegate {

    
    
    @IBOutlet weak var bulletinWeb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        restapisample()
        
        
    }
    

    
    func restapisample() {
        // Set up URL request
        let bulletinPage: String = "https://calvarycorvallis.org/wp-json/wp/v2/pages/1038"
        guard let url = URL(string: bulletinPage) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /pages/1038")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let bulletin = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: AnyObject] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                guard let bulletinContent = bulletin["content"]?["rendered"] as? String else {
                    print("Could not get bulletin content from JSON")
                    return
                }
                

                let htmlCode  = "<!DOCTYPE HTML><html><head><title></title><link rel='stylesheet' href='calvarystyle.css'></head><body>" + bulletinContent + "</body></html>"
                self.bulletinWeb.loadHTMLString(htmlCode, baseURL: nil)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

