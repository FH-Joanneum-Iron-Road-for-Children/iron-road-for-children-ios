//
//  ProgramItemView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemView: View {
	let event: Event

	private let rowHeight: CGFloat = 100

	var body: some View {
		HStack(spacing: 10) {
			Image("seiler-speer")
				.resizable()
				.scaledToFill()
				.frame(width: rowHeight, height: rowHeight)
				.clipped()

			VStack(alignment: .leading, spacing: 5) {
				Text(event.title)
					.font(.headline)

				Text(event.eventLocation.name)
					.font(.body)
			}

			Spacer()

			Text("\(DateFormatter.localTime(of: event.startDateTimeInUTC)) - \(DateFormatter.localTime(of: event.endDateTimeInUTC))")
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

extension DateFormatter {
	static func localTime(of utcDate: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current // Use the device's current time zone
		dateFormatter.dateFormat = "HH:mm" // Format the date and time as desired

		return dateFormatter.string(from: utcDate)
	}
}

// struct ProgramItemView_Previews: PreviewProvider {
//	static var previews: some View {
//		ProgramItemView()
//			.padding(8)
//
//		ProgramItemView()
//			.padding(8)
//			.preferredColorScheme(.dark)
//	}
// }
