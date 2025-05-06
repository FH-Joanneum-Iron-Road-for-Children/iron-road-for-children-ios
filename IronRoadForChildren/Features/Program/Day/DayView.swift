// Copyright © 2023 IRFC

import SwiftUI

struct DayView: View {
	@ObservedObject var viewModel: ProgramViewModel
	var events: [Event] = []

	var body: some View {
		ScrollView {
			LazyVStack {
				if events.isEmpty {
					Text("Keine Events, versuchen sie es mit einem anderen Filter!")
						.multilineTextAlignment(.center)
						.padding()
				} else {
					ForEach(events) { event in
						NavigationLink(destination: ProgramItemDetailView(event: event, viewModel: viewModel)) {
							ProgramListItemView(
								event: event,
								viewModel: viewModel
							)
							.padding(.top, 8)
							.padding(.horizontal, 16)
						}
						.buttonStyle(.plain)
					}
				}
			}
		}
		.padding(.bottom, 16)
	}
}

struct DayView_Previews: PreviewProvider {
	static var previews: some View {
		let viewModelInstance = ProgramViewModel(
			eventMocks: Mocks.events,
			eventCategoriesMocks: [Mocks.eventCategory]
		)
		return DayView(
			viewModel: viewModelInstance,
			events: Mocks.events
		)
	}
}
