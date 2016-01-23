//
//  Notification.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/22/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

enum NotificationType {
    case Follower
    case MUCMention
    case PhotoLike
    case MessageLike
    case NewPhoto
    case NewMessage
    case NewProfilePicture
    case None
    
    init() {
        self = .None
    }
}

class Notification: NSObject {
    
    internal var type = NotificationType()
    internal var username: String?
    internal var userName: String?
    internal var avatarImageURL: String?
    internal var avatarImage: UIImage?
    internal var notificationTypeText: String?
    internal var notificationDate: String?
    internal var notificationEvent: String?

    
    init(notificationData: NSDictionary) {
        
        /*
        There are a lot of unknown types, in requirement are only mentoed Like Post, Comment, and aslo NotificationEvent is 90% empty in API and i cant figure out what type notification is.
        */
        
        if let type =  notificationData.valueForKey("notificationType") as? String {
            switch type {
            case "Follower"             :   self.type = .Follower
            case "MUC mention"          :   self.type = .MUCMention
            case "Photo like"           :   self.type = .PhotoLike
            case "Message like"         :   self.type = .MessageLike
            case "New Message"          :   self.type = .NewMessage
            case "New Photo"            :   self.type = .NewPhoto
            case "New profile photo"    :   self.type = .NewProfilePicture
            default                     :   self.type = .None
            }
            
            print(type)
        }
        
        if let text = notificationData.valueForKey("notificationTypeText") as? String {
            self.notificationTypeText = text
        }
        
        if let event = notificationData.valueForKey("notificationEvent") as? String {
            self.notificationEvent = event
        }
        
        if let fullname = notificationData.valueForKey("fullname") as? String {
            self.username = NSString(format: "%@", fullname).stringByReplacingOccurrencesOfString("_", withString: " ")
        }
        
        if let avatarImageURL = notificationData.valueForKey("avatar_50") as? String {
            self.avatarImageURL = avatarImageURL
        }
        
        if let dateString = notificationData.valueForKey("notificationDate") as? String {
            let date = DateManager.convertStringToDate(dateString: dateString)
            self.notificationDate = DateManager.timeInWordsAgoFromDate(date: date)
        }
    }
    
}