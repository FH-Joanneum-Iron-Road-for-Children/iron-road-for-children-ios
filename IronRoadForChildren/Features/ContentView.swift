//
//  ContentView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.03.23.
//

import CoreUI
import ExampleMVVM
import SwiftUI

struct ContentView: View {
	private let irfcYellow = UIColor(.irfcYellow)
	private let irfcBlue = UIColor(.irfcBlue)

	private var shouldApplyBackground: Bool {
		guard #available(iOS 16, *) else {
			return true
		}
		return false
	}

	var body: some View {
		Group {
			if #available(iOS 16, *) {
				TabView {
					tabbarContent
						.toolbarColorScheme(.dark, for: .tabBar)
				}

			} else {
				TabView {
					tabbarContent
				}
			}
		}

		.onAppear {
			let tabBarAppearance = UITabBarAppearance()
			tabBarAppearance.backgroundColor = UIColor(.irfcBlue)

			let tabBar = UITabBar.appearance()
			tabBar.standardAppearance = tabBarAppearance
			tabBar.scrollEdgeAppearance = tabBarAppearance
		}
	}

	var tabbarContent: some View {
		Group {
			NavigationView {
				ProgramView()
					.navigationTitle("Programm")
					.navigationBarTitleDisplayMode(.inline)
			}
			.navigationViewStyle(.stack)
			.tabItem {
				Label("Program", image: "program")
			}

			NavigationView {
				VoteView()
					.navigationTitle("Voting")
			}
			.navigationViewStyle(.stack)
			.tabItem {
				Label("Vote", image: "vote")
			}

			NavigationView {
				MapView()
					.navigationTitle("Karte")
					.navigationBarTitleDisplayMode(.inline)
			}
			.navigationViewStyle(.stack)
			.tabItem {
				Label("Karte", image: "map")
			}

			NavigationView {
				MoreView()
					.navigationTitle("Über uns")
			}
			.navigationViewStyle(.stack)
			.tabItem {
				Label("More", systemImage: "ellipsis")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
			.previewDisplayName("ios 16")

		ContentView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
			.previewDisplayName("ios 16")
			.preferredColorScheme(.dark)

		ContentView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 13"))
			.previewDisplayName("ios 15")

		ContentView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 13"))
			.previewDisplayName("ios 15")
			.preferredColorScheme(.dark)
	}
}
