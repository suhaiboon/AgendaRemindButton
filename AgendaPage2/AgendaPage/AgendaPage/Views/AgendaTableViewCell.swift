//
//  AgendaTableViewCell.swift
//  AgendaPage
//
//  Created by Suhaib AlMutawakel on 7/30/19.
//  Copyright © 2019 Suhaib AlMutawakel. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

protocol agendaDelegate {
    func reminderPressed()
}


class AgendaTableViewCell: UITableViewCell
{
    
   // @IBOutlet weak var ImageBackground: UIImageView!
    // I do not know why are you using this
 
    var delegate: agendaDelegate?

    
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    

   @IBOutlet weak var remindBtn: UIButton!
    
    
    //Setting up the agenda cell based on the info received from tableview
    func setAgenda(agenda: Agenda){
        speakerImage.image = UIImage(named: agenda.speakerImage)
        //speakerImage.image = agenda.speakerImage
        
        speakerName.text = agenda.speakerName
        //startTime.text = "\(agenda.startTimeHours) : \(agenda.startTimeMinutes)"
        startTime.text = String(agenda.startTimeHours) + ":" + String(agenda.startTimeMinutes)
        duration.text = agenda.duration
        sessionTitle.text = agenda.sessionTitle
        //Setting the button tag equal to index so we keep track of buttons created
//        remindBtn.tag = myIndex
//
//        remindBtn.setImage(agenda.isSelected ? UIImage(named: "bellOn") : UIImage(named: "bellOff"), for: .normal)
    }
    
    
    //setting the Remind Me Button ON and OFF 
    var isOn: Bool = true
    
    //Function that handles once the remind button is pressed
    @IBAction func btnPressed(_ sender: Any) {
        
        //When the button is pressed for the first time it is set to on
        if isOn {
            isOn = false
            let id : String =  String(remindBtn!.tag)
            setNotification(id: id)
            remindBtn.setImage(UIImage(named: "bellOn"), for: .normal)

        } else {
            isOn = true
            let id : String =  String(remindBtn!.tag)
            removeNotificaiton(id: id)
            remindBtn.setImage(UIImage(named: "bellOff"), for: .normal)
        }
                
    }
    
    
    //trying to fix the repeated button reminder 
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        remindBtn.setImage(UIImage(named: "bellOff"), for: .normal)
//    }
//
    
    
    func setNotification (id : String) {
        let center = UNUserNotificationCenter.current()
        
        
        let content = UNMutableNotificationContent()
        let lectureTitle = agendas[remindBtn.tag].sessionTitle
        content.title = lectureTitle
        content.body = "Lecture: \(lectureTitle) is about to start in 5 minutes. Head to main hall."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["btnID": id]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.month = 9
        dateComponents.day = 7
        //dateComponents.hour = agendaItems[remindBtn.tag].startTimeHours
        dateComponents.hour = 11
        dateComponents.minute = 26
        //dateComponents.minute = agendaItems[remindBtn.tag].startTimeMinutes
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
//        Repeating the reminder/notification instead of set time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        

        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.add(request)
       
    }
    
    
    func removeNotificaiton(id : String){
        let center = UNUserNotificationCenter.current()
        
        
        center.getPendingNotificationRequests { (notifications) in
            //print("Count: \(notifications.count)")
            for item in notifications {
                //let userInfo = item.content.userInfo

                
//                let userInfo:Dictionary<AnyHashable,Any?> = item.content.userInfo
//                let infoDict :  Dictionary = userInfo as! Dictionary<String,String?>
//                let notifcationObjectId : String = infoDict["btnID"]!!
                
               //var dict : Dictionary = Dictionary<AnyHashable,Any>()
                //let yourData = userInfo["btnId"]
                
                //print(notifcationObjectId)
                
                 var notifcationObjectId = item.identifier
             
                if id == notifcationObjectId {
                    center.removePendingNotificationRequests(withIdentifiers: [id])
                    //center.removeDeliveredNotifications(withIdentifiers: ["btnID"])
                    print("done")
                    print(id, notifcationObjectId)
                }
//                else{
//                    print("nothing")
//                    print(id, notifcationObjectId)
//
//                }
                //print(item.content.userInfo)
            }

        }
        
        prepareForReuse()
    }
    
   
    
//    //@IBAction func remindPressed(_ sender: Any) {
//        delegate?.reminderPressed()
//       // remindBtn.setImage(UIImage(named: "belllicon"), for: .normal)
//
//
//        let center = UNUserNotificationCenter.current()
//
//        let content = UNMutableNotificationContent()
//        let lectureTitle = agendaItems[remindBtn.tag].sessionTitle
//        content.title = lectureTitle
//        content.body = "Lecture: \(lectureTitle) is about to start in 5 minutes. Head to main hall."
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound = UNNotificationSound.default
//
//        var dateComponents = DateComponents()
//        dateComponents.month = 8
//        dateComponents.day = 29
//        dateComponents.hour = agendaItems[remindBtn.tag].startTimeHours
//        dateComponents.minute = agendaItems[remindBtn.tag].startTimeMinutes
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        //Repeating the reminder/notification instead of set time
//        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//    }
    

    
    
    
    
    
    
//
//    var agenda: Agenda! {
//        didSet{
//            updateUI()
//        }
//    }
//
//    func updateUI() {
//        //ImageBackground.image = UIImage(named: agenda.placeholder)
////        ImageBackground.layer.shadowOpacity = 0.2 // opacity, 20%
////        ImageBackground.layer.shadowColor = UIColor.init(red:0.20, green:0.52, blue:0.90, alpha:1.0).cgColor
////        ImageBackground.layer.shadowRadius = 5 // HALF of blur
////        ImageBackground.layer.shadowOffset = CGSize(width: 0, height: 2) // Spread x, y
////        ImageBackground.layer.masksToBounds =  false
//
//    }
//
    
}


