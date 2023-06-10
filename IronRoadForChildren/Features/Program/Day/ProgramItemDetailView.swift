//
//  ProgramItemDelailView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemDetailView: View {
	let event: Event

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 8) {
				Text(event.title)
					.font(.title2)
					.padding()

				if let url = URL(string: event.picture.path) {
					AsyncImage(url: url) { image in
						image
							.resizable()
							.scaledToFit()
							.clipped()
							.padding(.horizontal)
							.padding(.bottom)
					} placeholder: {
						ZStack {
							Color.gray.opacity(0.1)
								.frame(height: 200)

							ProgressView()
						}
					}
				}

				Text("Uhrzeit")
					.font(.body)
					.padding(.horizontal)

				Text("\(world.localTimeHourMinute(of: event.startDateTimeInUTC)) - \(world.localTimeHourMinute(of: event.endDateTimeInUTC))")
					.font(.body)
					.padding(.bottom)
					.padding(.horizontal)

				Text(event.eventLocation.name)
					.font(.headline)
					.padding(.horizontal)

				Text(event.eventCategory.name)
					.font(.caption2)
					.padding(.bottom)
					.padding(.horizontal)

				Text(event.eventInfo.infoText)
					.font(.body)
					.lineLimit(4)
					.padding(.horizontal)

				ScrollView(.horizontal) {
					HStack {
						ForEach(event.eventInfo.pictures, id: \.id) { picture in
							if let url = URL(string: picture.path) {
								AsyncImage(url: url) { image in
									image
										.resizable()
										.scaledToFit()
										.frame(maxHeight: 100)
								} placeholder: {
									ZStack {
										Color.gray.opacity(0.1)
											.frame(height: 100)

										ProgressView()
									}
								}
							}
						}
					}
					.padding()
				}
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
}
