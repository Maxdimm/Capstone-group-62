//
//  EventDetailViewController.swift
//  Calvary Chapel
//
//  Created by Kevin Stine on 4/27/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    var eventDetail: Event?
    //var eventDetail: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("event detail: ", eventDetail)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
