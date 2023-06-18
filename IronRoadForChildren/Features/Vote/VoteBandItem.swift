//
//  VoteBandItem.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23.
//

import CoreUI
import SwiftUI

struct VoteBandItem: View {
	var name: String
	var description: String

	@State var choosenBand: Bool = false

	var body: some View {
		Button {
			choosenBand = !choosenBand
		} label: {
			VStack {
				bandName()

				bandImage()

				bandDescription()
			}
			.padding(.bottom)
			.overlay(RoundedRectangle(cornerRadius: 20)
				.stroke(.gray.opacity(0.3), lineWidth: 4)
			)
			.overlay(RoundedRectangle(cornerRadius: 20)
				.stroke(choosenBand ? Color.irfcYellow : Color.clear, lineWidth: 5)
			)
			.cornerRadius(20)
		}
	}

	func bandName() -> some View {
		HStack {
			Text(name)
				.font(.title)
				.fontWeight(.black)
				.foregroundColor(.primary)
				.lineLimit(2)
				.multilineTextAlignment(.leading)
				.padding()

			Spacer()
		}
	}

	func bandImage() -> some View {
		Image("irfcMap")
			.resizable()
			.scaledToFill()
	}

	func bandDescription() -> some View {
		HStack {
			Text(description)
				.font(.headline)
				.foregroundColor(.secondary)
				.padding()

			Spacer()
		}
	}
}

struct VoteBandItem_Previews: PreviewProvider {
	static var previews: some View {
		VoteBandItem(name: "JOSH", description: "FEAT. Herr Speer")
			.frame(height: 300)
			.padding()
	}
}
