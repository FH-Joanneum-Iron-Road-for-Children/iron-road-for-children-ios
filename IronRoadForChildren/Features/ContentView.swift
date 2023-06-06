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
	var body: some View {
		if #available(iOS 16, *) {
			TabView {
				Group {
					NavigationStack {
						ProgramView()
							.navigationTitle("Programm")
							.navigationBarTitleDisplayMode(.inline)
					}
					.navigationViewStyle(.stack)
					.tabItem {
						Label("Program", image: "program")
					}

					NavigationStack {
						VoteView()
							.navigationTitle("Voting 🗳️")
					}
					.navigationViewStyle(.stack)
					.tabItem {
						Label("Vote", image: "vote")
					}

					NavigationStack {
						MapView()
							.navigationTitle("Karten 🗺️")
							.navigationBarTitleDisplayMode(.inline)
					}
					.navigationViewStyle(.stack)
					.tabItem {
						Label("Karte", image: "map")
					}

					NavigationStack {
						MoreView()
							.navigationTitle("Über uns")
					}
					.navigationViewStyle(.stack)
					.tabItem {
						Label("More", systemImage: "ellipsis")
					}
				}
				.tint(.irfcAccentColor)
			}
			.tint(.irfcYellow)
		} else {
			TabView {
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
						.navigationTitle("Voting 🗳️")
				}
				.navigationViewStyle(.stack)
				.tabItem {
					Label("Vote", image: "vote")
				}

				NavigationView {
					MapView()
						.navigationTitle("Karten 🗺️")
						.navigationBarTitleDisplayMode(.inline)
				}
				.navigationViewStyle(.stack)
				.tabItem {
					Label("Karten", image: "map")
				}

				NavigationView {
					MoreView()
						.navigationTitle("Über uns")
				}
				.navigationViewStyle(.stack)
				.tabItem {
					Label("Mehr", systemImage: "ellipsis")
				}
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
