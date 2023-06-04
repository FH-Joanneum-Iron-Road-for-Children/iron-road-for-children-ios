//
//  VoteBandItem.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23.
//

import SwiftUI

struct VoteBandItem: View {
	@State var bandName: String = "Bandname"
	@State var bandDescription: String = "Band description test test"
	@State var choosedBand: Bool = false
	var body: some View {
		VStack {
			VStack {
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
							.lineLimit(3)
					}
					.layoutPriority(100)

					Spacer()
				}.padding()
                HStack {
                    Button(action: {
                                        choosedBand = !choosedBand
                                    }, label: {
                                        Text(choosedBand ? "Abwählen" : "Auswählen").padding()

                                    }).background(Color.irfcYellow)
                                        .clipShape(Capsule())
                    Spacer()
                }
				
				
					.padding()
			}
			.cornerRadius(10)
			.overlay(RoundedRectangle(cornerRadius: 10)
				.stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.1), lineWidth: 5)
			)
			.background(Color.white)
		}.cornerRadius(20)
            .frame(width: 300)
			.overlay(RoundedRectangle(cornerRadius: 10)
				.stroke(choosedBand ? Color.irfcYellow : Color.clear, lineWidth: 5)
			)
			.padding(4)
            .clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

struct VoteBandItem_Previews: PreviewProvider {
	static var previews: some View {
		VoteBandItem()
	}
}
