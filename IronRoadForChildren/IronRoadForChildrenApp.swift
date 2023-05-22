//
//  IronRoadForChildrenApp.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.03.23.
//

import SwiftUI

@main
struct IronRoadForChildrenApp: App {
	init() {
		let tabBarAppearance = UITabBarAppearance()
		tabBarAppearance.configureWithOpaqueBackground()
		tabBarAppearance.backgroundColor = UIColor(Color.irfcBlue)

		let unselectedColor = UIColor.white
		let selectedColor = UIColor(.irfcYellow)

		tabBarAppearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
		tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]
		tabBarAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor
		tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

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
