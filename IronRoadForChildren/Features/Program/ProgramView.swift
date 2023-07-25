// Copyright © 2023 IRFC

import CoreUI
import SwiftUI

struct ProgramView: View {
	@StateObject var viewModel = ProgramViewModel()
	@State var selectedTab: Int = 0

	var body: some View {
		VStack {
			if viewModel.isLoadingEvents {
				ProgressView()
			} else if let errorDesc = viewModel.errorMessage {
				generalError(errorDesc)
			} else if viewModel.eventDays.isEmpty {
				noEventsError()
			} else {
				programContent()
			}
		}
	}

	func generalError(_ errorDesc: String) -> some View {
		ErrorRetryView(
			title: "Es ist ein Fehler aufgetreten.",
			desc: errorDesc,
			retry: {
				Task {
					await viewModel.loadEvents()
				}
			}
		)
	}

	func noEventsError() -> some View {
		ErrorRetryView(
			title: "Derzeit gibt es noch kein Programm für die IRFC2023.",
			desc: nil,
			retry: {
				Task {
					await viewModel.loadEvents()
				}
			}
		)
	}

	func programContent() -> some View {
		VStack(spacing: 0) {
			ProgramTabBarHeader(
				currentTab: $selectedTab,
        tabBarOptions: viewModel.eventDays.map { ProgramTabBarOption(name: $0.name, date: $0.date) }
			)

			FiltersRowView()
				.environmentObject(viewModel)

			TabView(selection: $selectedTab) {
				ForEach(Array(viewModel.eventDays.enumerated()), id: \.offset) { index, day in
					if let filteredCategorie = viewModel.filteredCategorie {
						DayView(
							events: day.events.filter {
								$0.eventCategory.id == filteredCategorie.id
							}
						)
						.tag(index)
					} else {
						DayView(events: day.events)
							.tag(index)
					}
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
			ProgramView(
				viewModel: ProgramViewModel(
					eventMocks: Mocks.events,
					eventCategoriesMocks: Mocks.categories
				)
			)
			.navigationTitle("Program")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}
