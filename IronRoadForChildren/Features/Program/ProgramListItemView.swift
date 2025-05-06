// Copyright © 2023 IRFC

import NukeUI
import SwiftUI

struct ProgramListItemView: View {
	let event: Event
    @ObservedObject var viewModel: ProgramViewModel

	private let rowHeight: CGFloat = 100

	var body: some View {
		HStack(spacing: 10) {
			if let url = URL(string: event.picture.path) {
				LazyImage(url: url) { state in
					if let image = state.image {
						image
							.resizable()
							.scaledToFill()
							.frame(width: rowHeight, height: rowHeight)
							.clipped()
					} else {
						ZStack {
							Color.gray.opacity(0.1)
								.frame(width: rowHeight, height: rowHeight)

							if state.error == nil {
								ProgressView()
							}
						}
					}
				}
			}

            // Titel und Location
			VStack(alignment: .leading, spacing: 5) {
				Text(event.title)
					.font(.headline)

				Text(event.eventLocation.name)
					.font(.body)
			}

			Spacer()
            
            ZStack {
                VStack {
                    Spacer()
                    Text("\(world.localTimeHourMinute(of: event.startDateTimeInUTC)) - \(world.localTimeHourMinute(of: event.endDateTimeInUTC))")
                        .font(.body)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorit(event: event)
                        }) {
                            Image(systemName: viewModel.isFavorite(event) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                        // Minimaler Abstand zum Rand
                        .padding(.top, 8)
                        .padding(.trailing, 6)
                    }
                    Spacer()
                }
            }
        }
		.foregroundColor(.primary)
		.background(.background)
		.overlay(
			RoundedRectangle(cornerRadius: 16)
				.stroke(.gray, lineWidth: 1)
		)
		.cornerRadius(16)
		.frame(height: rowHeight)
		.shadow(color: .gray.opacity(0.20), radius: 4)
	}
}

struct ProgramItemView_Previews: PreviewProvider {
	static var previews: some View {
        let mockViewModel = ProgramViewModel(
            eventMocks: [Mocks.event],
            eventCategoriesMocks: [Mocks.eventCategory])
        ProgramListItemView(event: Mocks.event, viewModel: mockViewModel)
	}
}
