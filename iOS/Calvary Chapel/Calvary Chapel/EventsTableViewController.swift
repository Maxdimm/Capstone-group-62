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
    var events = [Event]()
    
    @IBOutlet weak var changeDate: UITextField!
    let datePicker = UIDatePicker()
    
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
    
    var month = String()
    var year = String()
    var beginningMonth = Int()
    var startDate = String()
    var endDate = String()
    var pickerTracker = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
   
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
        let startIndex = formattedStart.index(formattedStart.startIndex, offsetBy: 5)
        let endIndex = formattedStart.index(formattedStart.startIndex, offsetBy: 2)
        let month_name = formattedStart.substring(from: startIndex)
        beginningMonth = Int(month_name.substring(to: endIndex))!
        var fullURL = ""
        
        if (pickerTracker == true) {
            //print("Picker tracker is: ", pickerTracker)
            print("Start date: ", startDate)
            print("End date: ", endDate)
            fullURL = https+userName+":"+password+"@"+baseURL+startDate+"&date_end="+endDate
        } else {
            fullURL = https+userName+":"+password+"@"+baseURL+formattedStart+"&date_end="+formattedEnd
        }
        
        let urlToSend: NSURL = NSURL(string: fullURL)!
        
        do {
            _ = try String(contentsOf: urlToSend as URL)
        } catch let error {
            print(error)
        }
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend as URL)!
        parser.delegate = self
        let success:Bool = parser.parse()
        
        if success {
            print("parse success!")
        } else {
            print("parse failure!")
            let parserError = parser.parserError
            print(parserError!)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement=elementName;
        if (elementName == "item") {
            eventName = String()
            eventDate = String()
            eventMonth = String()
            eventLocation = String()
            eventStartTime = String()
            eventEndTime = String()
            eventGroupName = String()
            eventLeaderName = String()
            eventLeaderEmail = String()
            eventLeaderPhone = String()
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
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
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        strXMLData=strXMLData+"\n\n"+string
        
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
    
    func updateTable() {
        //pickerTracker = true
        
        endDate = getEndDate(start_date: startDate)
        //print("month int: ", month_int)
        
        //let monthComp = pickerDataSource[monthComponent][monthSelection.selectedRow(inComponent: monthComponent)]
        //let yearComp = pickerDataSource[yearComponent][monthSelection.selectedRow(inComponent: yearComponent)]
        
        //let monthInt = getMonthInt(monthName: monthComp)
        
        /*
        startDate = getStartDate(month_int: String(monthInt), year_int: yearComp)
        endDate = getEndDate(month_int: monthInt, year_int: yearComp)
        */
        //Wait 4 seconds before updating the events table to allow the users long enough to change both the month and the year if they choose
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print(self.startDate + " " + self.endDate)
            self.events.removeAll()
            self.loadXMLData()
            self.tableView.reloadData()
        })
 
        
    }
    
    func getStartDate(month_int: String, year_int: String) -> String {

        let startDate = year_int + "-" + month_int + "-01";
        
        return startDate
    }
    /*
    func getEndDate(month_int: String, year_int: String) -> String {
        let stringDate = getStartDate(month_int: month_int, year_int: year_int)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: stringDate)
        
        var components = DateComponents()
        components.setValue(1, for: .month)
        let month_from_now = Calendar.current.date(byAdding: components, to: newDate!)
        
        let endDate = dateFormatter.string(from: (month_from_now!-1))
        
        return endDate
    }
    */
    func getEndDate(start_date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: start_date)
        var start_components = DateComponents()
        var end_components = DateComponents()
        start_components.setValue(-1, for: .month)
        end_components.setValue(1, for: .month)
        
        print("New Date: ", newDate)
        let selected_month_from_start = Calendar.current.date(bySetting: .day, value: 1, of: newDate!)
        let month_prior = Calendar.current.date(byAdding: start_components, to: selected_month_from_start!)
        let month_from_now = Calendar.current.date(byAdding: end_components, to: selected_month_from_start!)
        startDate = dateFormatter.string(from: month_prior!)
        let endDate = dateFormatter.string(from: (selected_month_from_start!-1))
        print("month_prior: ", month_prior)
        
        return endDate
    }
    
    func getMonthInt(monthName: String) -> String {
        if (monthName == "January") {
            return "01"
        } else if (monthName == "February") {
            return "02"
        } else if (monthName == "March") {
            return "03"
        } else if (monthName == "April") {
            return "04"
        } else if (monthName == "May") {
            return "05"
        } else if (monthName == "June") {
            return "06"
        } else if (monthName == "July") {
            return "07"
        } else if (monthName == "August") {
            return "08"
        } else if (monthName == "September") {
            return "09"
        } else if (monthName == "October") {
            return "10"
        } else if (monthName == "November") {
            return "11"
        } else if (monthName == "December") {
            return "12"
        }
        
        return "";
    }
    
    func createDatePicker() {
        // format the picker
        datePicker.datePickerMode = UIDatePickerMode.date
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // bar button item 
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        changeDate.inputAccessoryView = toolbar
        
        changeDate.inputView = datePicker
    }
    
    func donePressed() {
        // format date 
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeStyle = .none
        pickerTracker = true
        startDate = dateFormatter.string(from: datePicker.date)
        updateTable()
        self.view.endEditing(true)
    }
}
