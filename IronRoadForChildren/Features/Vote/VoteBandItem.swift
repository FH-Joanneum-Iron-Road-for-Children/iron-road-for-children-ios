//
//  VoteBandItem.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23.
//

import CoreUI
import SwiftUI

struct VoteBandItem: View {
	@State var bandName: String = "Bandnameasdfasd fasd"
	@State var bandDescription: String = "Band description test test test test"
	@State var choosenBand: Bool = false

	var body: some View {
		VStack {
			VStack(spacing: 10) {
				Image("irfcMap")
					.resizable()
					.aspectRatio(contentMode: .fit)

				HStack {
					VStack(alignment: .leading) {
						Text(bandDescription)
							.font(.headline)
							.foregroundColor(.secondary)

						Text(bandName)
							.font(.title)
							.fontWeight(.black)
							.foregroundColor(.primary)
							.lineLimit(1)
					}

					Spacer()
				}
				.padding()

				HStack {
					Button(action: {
						choosenBand = !choosenBand
					}) {
						Text(choosenBand ? "Abwählen" : "Auswählen")
							.padding(4)
					}
					.buttonStyle(IrfcYellowRoundedButton())

					Spacer()
				}
				.padding()
			}
			.overlay(RoundedRectangle(cornerRadius: 20)
				.stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.1), lineWidth: 4)
			)
		}
		.overlay(RoundedRectangle(cornerRadius: 20)
			.stroke(choosenBand ? Color.irfcYellow : Color.clear, lineWidth: 5)
		)
		.cornerRadius(20)
		.padding()
	}
}

struct VoteBandItem_Previews: PreviewProvider {
	static var previews: some View {
		VoteBandItem()
			.frame(height: 300)
	}
}
