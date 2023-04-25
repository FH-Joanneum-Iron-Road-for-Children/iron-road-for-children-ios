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
			}
			.padding()
			Button(action: {
                choosedBand = !choosedBand
            }, label: {
                Text(choosedBand ? "Abwählen" : "Auswählen").padding()

            }).background(!choosedBand ? Color.irfcYellow : Color.white)
				.clipShape(Capsule())
				.padding()
		}
		.cornerRadius(10)
		.overlay(RoundedRectangle(cornerRadius: 10)
			.stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.1), lineWidth: 1)
		)
        .padding([.top, .horizontal])
        .background(choosedBand ? Color.irfcYellow : Color.clear)
        
	}
}

struct VoteBandItem_Previews: PreviewProvider {
	static var previews: some View {
		VoteBandItem()
	}
}
