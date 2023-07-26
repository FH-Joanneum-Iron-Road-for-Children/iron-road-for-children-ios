//
//  ProgramItemDelailView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import NukeUI
import SwiftUI

struct ProgramItemDetailView: View {
	let event: Event

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 8) {
				eventTitle()

				eventImage()

				timeAndDate()

				eventDescription()

				imageGallery()
			}
			.background(
				RoundedRectangle(cornerRadius: 10)
					.stroke(lineWidth: 1)
					.foregroundColor(.gray)
					.shadow(radius: 5, x: 0, y: 5)
			)
			.padding(.horizontal, 16)
		}
	}

	func eventTitle() -> some View {
		Text(event.title)
			.font(.title2)
			.padding()
	}

	@MainActor @ViewBuilder
	func eventImage() -> some View {
		if let url = URL(string: event.picture.path) {
			LazyImage(url: url) { state in
				if let image = state.image {
					image
						.resizable()
						.scaledToFit()
						.clipped()
						.padding(.horizontal)
						.padding(.bottom)
				} else {
					ZStack {
						Color.gray.opacity(0.1)
							.frame(width: .infinity, height: 200)

						if state.error == nil {
							ProgressView()
						}
					}
				}
			}
		}
	}

	@ViewBuilder
	func timeAndDate() -> some View {
		HStack {
			VStack(alignment: .leading) {
				Label("Uhrzeit", systemImage: "clock")
					.font(.body.bold())

				Text("\(world.localTimeHourMinute(of: event.startDateTimeInUTC)) - \(world.localTimeHourMinute(of: event.endDateTimeInUTC))")
					.font(.body)
			}

			Spacer()

			VStack(alignment: .leading) {
				Label("Datum", systemImage: "calendar")
					.font(.body.bold())

				Text("\(world.localDate(of: event.startDateTimeInUTC))")
					.font(.body)
			}
		}
		.padding()
	}

	@ViewBuilder
	func locationAndCategory() -> some View {
		EqualIconWidthDomain {
			Label(event.eventLocation.name, systemImage: "mappin")
				.font(.body)
				.padding(.horizontal)
				.imageScale(.small)

			Label(event.eventCategory.name, systemImage: "tag")
				.font(.body)
				.padding(.horizontal)
				.imageScale(.small)
		}
	}

	@ViewBuilder
	func eventDescription() -> some View {
		if let attributedString = event.eventInfo.infoText.attributedMarkdownString {
			Text(attributedString)
				.font(.body)
				.lineLimit(4)
				.padding(.horizontal)
				.padding(.top)
		} else {
			Text(event.eventInfo.infoText)
				.font(.body)
				.lineLimit(4)
				.padding(.horizontal)
				.padding(.top)
		}
	}

	@ViewBuilder
	func imageGallery() -> some View {
		ScrollView(.horizontal) {
			LazyHStack {
				ForEach(event.eventInfo.pictures, id: \.id) { picture in
					imageGalleryPreview(picture: picture)
						.padding(.horizontal)
				}
			}
			.padding()
		}
	}

	@ViewBuilder
	func imageGalleryPreview(picture: Picture) -> some View {
		if let url = URL(string: picture.path) {
			AsyncImage(url: url) { image in
				image
					.resizable()
					.scaledToFit()
					.frame(maxHeight: 100)
			} placeholder: {
				ZStack {
					Color.gray.opacity(0.1)
						.frame(width: 140, height: 100)

					ProgressView()
				}
			}
		}
	}
}

struct ProgrammItemDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ProgramItemDetailView(event: Mocks.event)
			.padding()
	}
}
