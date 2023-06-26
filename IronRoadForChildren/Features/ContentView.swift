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
			iOS16UpView()
		} else {
			iOS15View()
		}
	}

	@available(iOS 16, *)
	private func iOS16UpView() -> some View {
		TabView {
			Group {
				NavigationStack {
					programView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					programLabel()
				}

				NavigationStack {
					votesView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					votesLabel()
				}

				NavigationStack {
					eventMapView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					eventMapView()
				}

				NavigationStack {
					moreView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					moreLabel()
				}
			}
			.tint(.irfcAccentColor)
		}
		.tint(.irfcYellow)
	}

	private func iOS15View() -> some View {
		TabView {
			Group {
				NavigationView {
					programView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					programLabel()
				}

				NavigationView {
					votesView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					votesLabel()
				}

				NavigationView {
					eventMapView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					eventMapLabel()
				}

				NavigationView {
					moreView()
				}
				.navigationViewStyle(.stack)
				.tabItem {
					moreLabel()
				}
			}
		}
	}

	private func programView() -> some View {
		ProgramView()
			.navigationTitle("Programm")
			.navigationBarTitleDisplayMode(.inline)
			.navigationViewStyle(.stack)
	}

	private func programLabel() -> some View {
		Label("Program", image: "program")
	}

	private func votesView() -> some View {
		VotesView()
			.navigationTitle("Voting")
			.navigationViewStyle(.stack)
	}

	private func votesLabel() -> some View {
		Label("Voting", image: "vote")
	}

	private func eventMapView() -> some View {
		EventMapView()
			.navigationTitle("Karte")
			.navigationBarTitleDisplayMode(.inline)
			.navigationViewStyle(.stack)
	}

	private func eventMapLabel() -> some View {
		Label("Karte", image: "map")
	}

	private func moreView() -> some View {
		MoreView()
			.navigationTitle("Über uns")
			.navigationViewStyle(.stack)
	}

	private func moreLabel() -> some View {
		Label("Mehr", systemImage: "ellipsis")
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
