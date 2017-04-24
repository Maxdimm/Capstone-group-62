//
//  EventTableViewController.swift
//  Calvary Chapel
//
//  Created by Kevin Stine on 2/17/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController, XMLParserDelegate {
    
    class Event {
        var name: String?
        var month: String?
        var date: String?
        /*
        init?(name: String, month: String, date: String) {
            self.name = name
            self.month = month
            self.date = date
            
            if name.isEmpty {
                return nil
            }
        }
        */
    }
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = XMLParser()
    
    //Mark: Properties
    var events: [Event] = []
    //I added these two global variables - CB
    var eventName = String()
    var eventDate = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //loadSampleEvents()
        loadXMLData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "EventsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventsTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell")
        }

        let event = events[indexPath.row]
        
        
        // Configure the cell...
        cell.eventLabel.text = event.name
        cell.monthLabel.text = event.month
        cell.dateLabel.text = event.date
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private Methods
    /*
    private func loadSampleEvents() {
        
        guard let event1 = Event(name: "Sunday Church", month: "February", date: "8") else {
            fatalError("Unable to instatitate event1")
        }
        
        guard let event2 = Event(name: "Life Group", month: "February", date: "10") else {
            fatalError("Unable to instatiate event2")
        }
        
        guard let event3 = Event(name: "Worship Practice", month: "February", date: "12") else {
            fatalError("Unable to instantiate event3")
        }
        
        events += [event1, event2, event3]
    }
    */
    
    private func loadXMLData() {
        let userName = "bonncosu"
        let password = "bonnc123"
        let https = "https://"
        let baseURL = "calvarycorvallis.ccbchurch.com/api.php?srv=public_calendar_listing&date_start="
        
        let dateFormatter = DateFormatter()
        let date = NSDate()
        
        // Specify the format for the date since CCB excepts the date as yyyy-MM-dd
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print(dateFormatter.string(from: date as Date))
        
        let formattedDate = dateFormatter.string(from: date as Date)
        
        // Append the formatted date to the base URL to have the full URL to connect to CCB
        
        
        // This is the correct url, however it is commented out for testing purposes
        //let fullURL = https+userName+":"+password+"@"+baseURL+formattedDate
        
        let fullURL = "https://bonncosu:bonnc123@calvarycorvallis.ccbchurch.com/api.php?srv=public_calendar_listing&date_start=2017-03-05"
        
      //  print(fullURL)
        
        let urlToSend: NSURL = NSURL(string: fullURL)!
        
        do {
            let test = try String(contentsOf: urlToSend as URL)
         //   print(test)
        } catch let error {
            print(error)
        }
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend as URL)!
       // print(parser)
        parser.delegate = self
        
        let success:Bool = parser.parse()
        
  //      let event = events
        
        if success {
            print("parse success!")
            
       //     print(strXMLData)
       //     event.name = strXMLData
        } else {
            print("parse failure!")
            let parserError = parser.parserError
            print(parserError!)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement=elementName;
        if(elementName=="event_name" || elementName=="event_name" || elementName=="event_description" || elementName=="start_time" || elementName=="event_name")
        {
            if(elementName=="event_name"){
                passName=true;
                //assign eventName to String() - CB
                eventName = String()
            }
            passData=true;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       // currentElement=""; //i commented out this line because we want to keep the currentElement from above
        if(elementName=="name" || elementName=="event_name" || elementName=="event_description" || elementName=="start_time" || elementName=="end_time")
        {
            if(elementName=="event_name"){
                passName=false;
                
                //I added the following 4 lines of code -CB
                let event = Event()
                event.name = eventName
                event.month = eventDate
                
                events.append(event)
            }
            passData=false;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //I added this if/else statement - CB
        if (currentElement == "event_name") {
            eventName += string
        } else if (currentElement == "date") {
            
            let date_string = "2017-04-24" as String
            let startIndex = date_string.index(date_string.startIndex, offsetBy: 5)
            let endIndex = date_string.index(date_string.startIndex, offsetBy: 2)

            let day = date_string.substring(to: startIndex)
            print("day: ", day)
            let month = date_string.substring(from: startIndex)
            print("month: ", month)
            
            var month_int = month.substring(to: endIndex)
            print ("day substring: ", month_int)
            
            var month_value = ""
            
            if month_int == "01" {
                month_value = "January"
            } else if month_int == "02" {
                month_value = "February"
            } else if month_int == "03" {
                month_value = "March"
            } else if month_int == "04" {
                month_value = "April"
            } else if month_int == "05" {
                month_value = "May"
            } else if month_int == "06" {
                month_value = "June"
            } else if month_int == "07" {
                month_value = "July"
            } else if month_int == "08" {
                month_value = "August"
            } else if month_int == "09" {
                month_value = "September"
            } else if month_int == "10" {
                month_value = "October"
            } else if month_int == "11" {
                month_value = "November"
            } else if month_int == "12" {
                month_value = "December"
            } else {
                month_value = "N/A"
            }
            
            eventDate = month_value
        }
    
        
        //Not sure if these two if statements are necessary anymore but I didn't want to delete them in case they were - CB
        if(passName){
            strXMLData=strXMLData+"\n\n"+string
        }
        
        if(passData)
        {
            print(string)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
    
}
