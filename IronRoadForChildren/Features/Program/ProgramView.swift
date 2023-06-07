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
				VStack {
					Text("Es ist ein Fehler aufgetreten.")
						.multilineTextAlignment(.center)
						.padding(.horizontal)

					Text(errorDesc)
						.multilineTextAlignment(.center)
						.font(.caption)
						.padding()
						.padding(.horizontal)
						.padding(.horizontal)

					Button("Erneut versuchen") {
						viewModel.loadEvents()
					}
					.buttonStyle(IrfcYellowRoundedButton())
					.padding(.horizontal)
				}
			} else {
				VStack(spacing: 0) {
					ProgramTabBarHeader(
						currentTab: $selectedTab,
						tabBarOptions: viewModel.dayEvents.map { $0.name }
					)

					if viewModel.isLoadingCategories {
						ProgressView()
							.padding()
					} else {
						FiltersRowView()
					}

					TabView(selection: $selectedTab) {
						ForEach(Array(viewModel.dayEvents.enumerated()), id: \.offset) { index, day in
							DayView(events: day.events)
								.tag(index)
						}
					}
					.tabViewStyle(.page(indexDisplayMode: .never))
					.animation(.easeInOut(duration: 0.3), value: selectedTab)
				}
				.animation(.easeIn, value: viewModel.dayEvents)
			}
		}
	}
}

struct ProgramView_Previews: PreviewProvider {
	static var previews: some View {
		ProgramView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
			.previewDisplayName("ios 16")

		ProgramView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 13"))
			.previewDisplayName("ios 15")
	}
}
