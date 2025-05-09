// Copyright © 2025 IRFC

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notifications erlaubt")
            } else if let error = error {
                print("Fehler bei der Anfrage: \(error.localizedDescription)")
            }
        }
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
    }
}


@main
struct IronRoadForChildrenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	private let irfcYellow = UIColor(.irfcYellow)
	private let irfcBlue = UIColor(.irfcBlue)

	init() {
		let tabBarAppearance = UITabBarAppearance()
		tabBarAppearance.configureWithOpaqueBackground()
		tabBarAppearance.backgroundColor = UIColor(.irfcBlue)

		tabBarAppearance.stackedLayoutAppearance.selected.iconColor = irfcYellow
		tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: irfcYellow]

		let tabBar = UITabBar.appearance()
		tabBar.tintColor = irfcYellow
		tabBar.standardAppearance = tabBarAppearance
		tabBar.scrollEdgeAppearance = tabBarAppearance
        
        NotificationManager.shared.requestAuthorization()
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
