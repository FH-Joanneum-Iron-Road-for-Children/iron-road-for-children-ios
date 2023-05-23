//
//  ProgramItemView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemView: View {
	private let rowHeight: CGFloat = 100

	var body: some View {
		HStack(spacing: 10) {
			Image("seiler-speer")
				.resizable()
				.scaledToFill()
				.frame(width: rowHeight, height: rowHeight)
				.clipped()

			VStack(alignment: .leading, spacing: 5) {
				Text("Seiler & Speer")
					.font(.headline)

				Text("STAGE HAS ALSO A LONG NAME")
					.font(.body)
			}

			Spacer()

			Text("16:00 - 16:40")
				.font(.system(size: 16))
				.fontWeight(.semibold)
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
		ProgramItemView()
			.padding(8)

		ProgramItemView()
			.padding(8)
			.preferredColorScheme(.dark)
	}
}
