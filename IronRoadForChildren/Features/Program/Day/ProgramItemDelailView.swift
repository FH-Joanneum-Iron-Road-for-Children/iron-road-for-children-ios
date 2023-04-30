//
//  ProgramItemDelailView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemDelailView: View {
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("BAND NAME")
				.font(.title2)
				.padding(.vertical, 24)
				.padding(.horizontal, 16)

			Image(systemName: "photo")
				.resizable()
				.scaledToFit()
				.frame(maxHeight: 200)
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
				.font(.footnote)
				.lineLimit(4)
				.padding(.horizontal, 16)

			HStack {
				Image(systemName: "photo")
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
				.fill(Color(red: 1.0, green: 0.96, blue: 0.9))
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
