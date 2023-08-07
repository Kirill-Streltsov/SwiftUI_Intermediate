//
//  LocalNotificationsBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooo easy!"
        content.sound = .default
        content.badge = 1
        
        // time
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // calendar
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 41
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 10,
            identifier: "")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: locationTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsBootcamp()
    }
}
