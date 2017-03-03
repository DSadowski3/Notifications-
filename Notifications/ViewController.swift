//
//  ViewController.swift
//  Notifications
//
//  Created by Dominik Sadowski on 3/3/17.
//  Copyright © 2017 Dominik Sadowski. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
        
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("Successfully scheduled Notification")
            } else {
                print("Error in notificaiton")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        
        let notificaiton = UNMutableNotificationContent()
        notificaiton.categoryIdentifier = "myNotificationCategory"
        notificaiton.title = "New Notificaiton"
        notificaiton.subtitle = "I Love to notify"
        notificaiton.body = "The new notificaiton will let you know more about yourself as a user!"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotif", content: notificaiton, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            
            if error != nil {
                print(error ?? "")
                completion(false)
            }else {
                completion(true)
            }
        }
    }


}

