//
//  ProgramView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import CoreUI
import SwiftUI

struct ProgramView: View {
	@StateObject var viewModel = ProgramViewModel()
	@State var selectedTab: Int = 0

	var body: some View {
		VStack {
			if viewModel.isLoadingEvents {
				ProgressView()
			} else if let errorDesc = viewModel.error {
				ErrorRetryView(
					title: "Es ist ein Fehler aufgetreten.",
					desc: errorDesc,
					retry: {
						viewModel.loadEvents()
					}
				)
			} else if viewModel.dayEvents.isEmpty {
				ErrorRetryView(
					title: "Derzeit gibt es noch kein Programm für die IRFC2023.",
					desc: nil,
					retry: {
						viewModel.loadEvents()
					}
				)
			} else {
				programContent
			}
		}
	}

	var programContent: some View {
		VStack(spacing: 0) {
			ProgramTabBarHeader(
				currentTab: $selectedTab,
				tabBarOptions: viewModel.dayEvents.map { $0.name }
			)

			FiltersRowView()
				.environmentObject(viewModel)

			TabView(selection: $selectedTab) {
				ForEach(Array(viewModel.dayEvents.enumerated()), id: \.offset) { index, day in
					DayView(events: day.events)
						.tag(index)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.animation(.easeInOut(duration: 0.3), value: selectedTab)
		}
	}
}

struct ProgramView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProgramView()
				.navigationTitle("Program")
				.navigationBarTitleDisplayMode(.inline)
		}
	}
}
