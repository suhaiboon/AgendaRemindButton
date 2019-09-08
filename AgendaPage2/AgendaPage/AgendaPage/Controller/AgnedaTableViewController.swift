//
//  AgnedaTableViewController.swift
//  AgendaPage
//
//  Created by Suhaib AlMutawakel on 7/30/19.
//  Copyright © 2019 Suhaib AlMutawakel. All rights reserved.
//

import UIKit
import UserNotifications


var myIndex : Int = 0
//var agendaItems: [Agenda] = []
var agendas : [Agenda] = []

class AgnedaTableViewController: UIViewController
{
    
    @IBOutlet weak var tableview: UITableView!
    

    
    override func viewDidLoad() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in}
            
        tableview.backgroundColor = UIColor.clear
        //agendaItems = createAgendaItems()
        parsesAgendaCSV()
    }
    
 
    func parsesAgendaCSV(){
        //let path = Bundle.main.path(forResource: "agenda", ofType: "csv")!
        
        do {
            let csv = try CSV(
                name: "agenda",
                extension: "csv",
                bundle: .main,
                delimiter: ",",
                encoding: .utf8)
            let rows = csv!.namedRows
            
            for row in rows{
                let speakerName = row["speakerName"]!
                let sessionTitle = row["sessionTitle"]!
                let startMinutes = Int(row["startTimeMinutes"]!)!
                let startHours = Int(row["startTimeHours"]!)!
                let duration = row["duration"]!
                let imageName = row["imageName"]!
                
                let item = Agenda(speakerImage:imageName, sessionTitle: sessionTitle, speakerName: speakerName, startTimeHours: Int(startHours), startTimeMinutes: Int(startMinutes), duration: duration)
                
                agendas.append(item)
            }
     
            
        } catch {
            // Catch errors from trying to load files
        }
        
    }
    
    
//    func createAgendaItems()->[Agenda]{
//        var tempArray: [Agenda] = []
//        
//        let item1 = Agenda(speakerImage: UIImage(named: "Profile Pic Small")!, sessionTitle: "First Session", speakerName: "Dr.Suhaib", startTimeHours: 14, startTimeMinutes: 00, duration: "25:00")
//        let item2 = Agenda(speakerImage: UIImage(named: "Profile Pic Small")!, sessionTitle: "Second Session", speakerName: "Dr. Tareq", startTimeHours: 14, startTimeMinutes: 48, duration: "15:00")
//        let item3 = Agenda(speakerImage: UIImage(named: "Profile Pic Small")!, sessionTitle: "Third Session", speakerName: "Dr. Boon", startTimeHours: 14, startTimeMinutes: 48, duration: "30:00")
//
//        tempArray.append(item1)
//        tempArray.append(item2)
//        tempArray.append(item3)
//        
//        return tempArray
//        
//    }
    
    
}




extension AgnedaTableViewController : UITableViewDataSource, UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendas.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = agendas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath) as! AgendaTableViewCell
        myIndex = indexPath.row
        cell.setAgenda(agenda: currentItem)
        cell.backgroundColor = UIColor.clear
        //cell.delegate = self as? agendaDelegate
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        //let agenda = agendas[indexPath.row]
        //cell.agenda = agenda
    
        return cell
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        print(indexPath)
//    }
  
}


//extension AgnedaTableViewController: agendaDelegate{
//    
//    func reminderPressed(){
//        let center = UNUserNotificationCenter.current()
//        
//        let content = UNMutableNotificationContent()
//        let lectureTitle = agendaItems[myIndex].sessionTitle
//        content.title = agendaItems[myIndex].sessionTitle
//        content.body = "Lecture: \(lectureTitle) is about to start in 5 minutes. Head to main hall."
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound = UNNotificationSound.default
//        
//        var dateComponents = DateComponents()
//        //dateComponents.month = 8
//        //dateComponents.day = 28
//        dateComponents.hour = agendaItems[myIndex].startTimeHours
//        dateComponents.minute = agendaItems[myIndex].startTimeMinutes
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        //Repeating the reminder/notification instead of set time
//        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//       
//    }
//}
