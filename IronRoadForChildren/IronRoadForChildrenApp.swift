//
//  IronRoadForChildrenApp.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.03.23.
//

import SwiftUI

@main
struct IronRoadForChildrenApp: App {
	private let irfcYellow = UIColor(.irfcYellow)
	private let irfcBlue = UIColor(.irfcBlue)

	init() {
		let tabBarAppearance = UITabBarAppearance()
		tabBarAppearance.configureWithOpaqueBackground()
		tabBarAppearance.backgroundColor = UIColor(.irfcBlue)

		let tabBar = UITabBar.appearance()
		tabBar.standardAppearance = tabBarAppearance
		tabBar.scrollEdgeAppearance = tabBarAppearance
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
