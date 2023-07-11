// Copyright © 2023 IRFC

import SwiftUI

struct ProgramListItemView: View {
	let event: Event

	private let rowHeight: CGFloat = 100

	var body: some View {
		HStack(spacing: 10) {
			if let url = URL(string: event.picture.path) {
				AsyncImage(url: url) { image in
					image
						.resizable()
						.scaledToFill()
						.frame(width: rowHeight, height: rowHeight)
						.clipped()
				} placeholder: {
					ZStack {
						Color.gray.opacity(0.1)
							.frame(width: rowHeight, height: rowHeight)

						ProgressView()
					}
				}
			}

			VStack(alignment: .leading, spacing: 5) {
				Text(event.title)
					.font(.headline)

				Text(event.eventLocation.name)
					.font(.body)
			}

			Spacer()

			Text("\(world.localTimeHourMinute(of: event.startDateTimeInUTC)) - \(world.localTimeHourMinute(of: event.endDateTimeInUTC))")
				.font(.body)
				.padding(.trailing, 8)
				.lineLimit(1)
				.fixedSize(horizontal: true, vertical: false)
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
		ProgramListItemView(event: Mocks.event)
	}
}
