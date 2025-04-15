// Copyright © 2025 IRFC

import UserNotifications
import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(for event: Event) {
        let startDate = event.startDateTimeInUTC
        // let startDate = Date().addingTimeInterval(2 * 60) // for testing
        
        let calculatedNotificationDate = Calendar.current.date(byAdding: .minute, value: -15, to: startDate) // 15 Minuten vor Start auslösen
        
        let notificationDate: Date
        if let calcDate = calculatedNotificationDate, calcDate > Date() {
            notificationDate = calcDate
        } else {
            notificationDate = Date().addingTimeInterval(1) // wenn < 15 min, sofort auslösen
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Bald geht's los: \(event.title)"
        content.body = "Dein favorisiertes Event \(event.title) startet bald. Ort: \(event.eventLocation)."
        content.sound = .default
        
        let trigger: UNNotificationTrigger
        if notificationDate > Date() {
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        }
        
        let identifier = "eventNotification_\(event.id)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Fehler beim Planen der Notification: \(error.localizedDescription)")
            } else {
                print("Notification für \(event.title) geplant.")
            }
        }
    }

    func cancelNotification(for event: Event) {
        let identifier = "eventNotification_\(event.id)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("Notification für \(event.title) entfernt.")
    }
}
