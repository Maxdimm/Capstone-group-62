//
//  SecondViewController.swift
//  Calvary Chapel - Bulletin
//
//  Created by Kevin Stine on 1/11/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func JSONData(_ sender: UIButton) {
        
        restapisample()
    }
    func restapisample() {
        // Set up URL request
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            //make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            //parse the result as JSON
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                //now we have the todo
                //let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                //the todo object is a dictionary
                //so we just access the title using the "title" key
                //so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch {
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

