//
//  ProgramItemDelailView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemDelailView: View {
	let horizontalPadding: CGFloat = 16
	// Calculate image width based on screen width and padding
	let imageWidth = UIScreen.main.bounds.width - (2 * 16)

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("BAND NAME")
				.font(.title2)
				.padding(.vertical, 24)
				.padding(.horizontal, 16)

			Image(systemName: "person.2.fill")
				.resizable()
				.scaledToFill()
				.frame(width: imageWidth)
				.frame(maxHeight: 200)
				.clipped()
				.padding(.bottom, 16)

			Text("Uhrzeit")
				.font(.body)
				.padding(.horizontal, 16)

			Text("13:00 - 13:40")
				.font(.body)
				.padding(.bottom, 16)
				.padding(.horizontal, 16)

			Text("Family Rock Stack")
				.font(.body)
				.padding(.horizontal, 16)

			Text("ROCK MUSIC")
				.font(.body)
				.padding(.bottom, 16)
				.padding(.horizontal, 16)

			Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut dapibus, arcu at posuere maximus, nibh dui facilisis velit.")
				.font(.body)
				.lineLimit(4)
				.padding(.horizontal, 16)

			HStack {
				Image(systemName: "person.2")
					.resizable()
					.scaledToFit()
					.frame(maxHeight: 100)

				Image(systemName: "photo")
					.resizable()
					.scaledToFit()
					.frame(maxHeight: 100)
			}
			.padding(16)
		}
		.background(
			RoundedRectangle(cornerRadius: 10)
				.stroke(lineWidth: 2) // Use stroke instead of fill to draw the frame
				.shadow(radius: 5, x: 0, y: 5)
		)
		.padding(.horizontal, 16)
	}
}

struct ProgramItemDelailView_Previews: PreviewProvider {
	static var previews: some View {
		ProgramItemDelailView()
	}
}
