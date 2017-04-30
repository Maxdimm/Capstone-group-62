//
//  EventTableViewController.swift
//  Calvary Chapel
//
//  Created by Kevin Stine on 2/17/17.
//  Copyright © 2017 Capstone Group 62. All rights reserved.
//

import UIKit

class Event {
    var name: String?
    var month: String?
    var date: String?
    var location: String?
    var startTime: String?
    var endTime: String?
    var groupName: String?
    var leaderName: String?
    var leaderEmail: String?
    var leaderPhone: String?
}

class EventsTableViewController: UITableViewController, XMLParserDelegate {
    
    
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = XMLParser()
    
    //Mark: Properties
    //var events: [Event] = []
    var events = [Event]()
    
    //I added these two global variables - CB
    var eventName = String()
    var eventDate = String()
    var eventMonth = String()
    var eventLocation = String()
    var eventStartTime = String()
    var eventEndTime = String()
    var eventGroupName = String()
    var eventLeaderName = String()
    var eventLeaderEmail = String()
    var eventLeaderPhone = String()
    
    
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EventDetailViewController {
                let eventIndex = tableView.indexPathForSelectedRow?.row
                let event = events[eventIndex!]
                destinationVC.destinationEvent = event
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
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
        let formattedStart = dateFormatter.string(from: date as Date)
        var components = DateComponents()
        components.setValue(1, for: .month)
        let month_from_now = Calendar.current.date(byAdding: components, to: date as Date)
        let formattedEnd = dateFormatter.string(from: month_from_now!)
        let fullURL = https+userName+":"+password+"@"+baseURL+formattedStart+"&date_end="+formattedEnd
        let urlToSend: NSURL = NSURL(string: fullURL)!
        
        do {
            let test = try String(contentsOf: urlToSend as URL)
        } catch let error {
            print(error)
        }
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend as URL)!
        parser.delegate = self
        let success:Bool = parser.parse()
        
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
        if(elementName=="event_name" || elementName=="date" || elementName=="location" || elementName=="start_time" || elementName=="end_time" || elementName=="group_name" || elementName == "leader_name" || elementName == "leader_phone" || elementName == "leader_email")
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
        if(elementName=="date" || elementName=="event_name" || elementName=="location" || elementName=="start_time" || elementName=="end_time" || elementName=="group_name" || elementName == "leader_name" || elementName == "leader_phone" || elementName == "leader_email")
        {
            if(elementName=="event_name"){
                passName=false;
                
                //I added the following 4 lines of code -CB
                let event = Event()
                event.name = eventName
                event.month = eventMonth
                event.date = eventDate
                event.location = eventLocation
                event.startTime = eventStartTime
                event.endTime = eventEndTime
                event.groupName = eventGroupName
                event.leaderName = eventLeaderName
                event.leaderPhone = eventLeaderPhone
                event.leaderEmail = eventLeaderEmail
                events.append(event)
            }
            passData=false;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //I added this if/else statement - CB
        if (currentElement == "event_name") {
            eventName += string
        } else if (currentElement == "location") {
            eventLocation += string
        } else if (currentElement == "start_time") {
            eventStartTime += string
        } else if (currentElement == "end_time") {
            eventEndTime += string
        } else if (currentElement == "group_name") {
            eventGroupName += string
        } else if (currentElement == "leader_name") {
            eventLeaderName += string
        } else if (currentElement == "leader_phone") {
            eventLeaderPhone += string
        } else if (currentElement == "leader_email") {
            eventLeaderEmail += string
        } else if (currentElement == "date") {
            let date_string = string
            let startIndex = date_string.index(date_string.startIndex, offsetBy: 5)
            let endIndex = date_string.index(date_string.startIndex, offsetBy: 2)
            let dayIndex = date_string.index(date_string.startIndex, offsetBy: 8)
            let day = date_string.substring(from: dayIndex)
            let month = date_string.substring(from: startIndex)
            let month_int = month.substring(to: endIndex)
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
                return
            }
            eventMonth = month_value
            eventDate = day
        }
    
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
    
}
