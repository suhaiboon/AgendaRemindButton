//
//  Agenda.swift
//  Provide The Agenda for the Conference
//
//  Created by Suhaib AlMutawakel on 7/30/19.
//  Copyright © 2019 Suhaib AlMutawakel. All rights reserved.
//

import Foundation
import UIKit

class Agenda{
    
    var speakerImage: String
    var sessionTitle: String
    var speakerName: String
    var startTimeHours: Int
    var startTimeMinutes: Int
    var duration: String
    
    
    init(speakerImage: String, sessionTitle: String, speakerName: String, startTimeHours: Int, startTimeMinutes: Int,  duration: String){
        self.speakerImage = speakerImage
        self.sessionTitle = sessionTitle
        self.speakerName = speakerName
        self.startTimeHours = startTimeHours
        self.startTimeMinutes = startTimeMinutes
        self.duration = duration
    }
    
    
    var hasReminder: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: self.sessionTitle)
        }
        get {
            return UserDefaults.standard.bool(forKey: self.sessionTitle)
        }
    
    }
    
}




//
//struct Agenda
//{
////    let speakerName: String
////    let lectureTitle: String
////    let lectureStartTime: String
////    let lectureDuration: String
//    let placeholder: String
//
//    static func fetchSpeaker() -> [Agenda] {
//        let s1 = Agenda(placeholder: "image1")
//        let s2 = Agenda(placeholder: "image1")
//        let s3 = Agenda(placeholder: "image1")
//        let s4 = Agenda(placeholder: "image1")
////        let s1 = Agenda(speakerName: "Suhaib Mutawakel", lectureTitle: "Code with Suhaib", lectureStartTime: "3:00", lectureDuration: "35 Minutes")
////         let s2 = Agenda(speakerName: "Oussama Ajerd", lectureTitle: "New World Connection", lectureStartTime: "12:00", lectureDuration: "20 Minutes")
////         let s3 = Agenda(speakerName: "Sarah Jamal", lectureTitle: "Coffee is Life", lectureStartTime: "10:30", lectureDuration: "15 Minutes")
////         let s4 = Agenda(speakerName: "Sam Sammy", lectureTitle: "Come and Go", lectureStartTime: "9:15", lectureDuration: "10 Minutes")
////
//
//        return [s1,s2,s3,s4]
//    }
//}
