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

	private var cornerRadius: CGFloat = 20

	init(name: String, description: String) {
		self.name = name
		self.description = description
	}

	var body: some View {
		Button {
			choosenBand = !choosenBand
		} label: {
			VStack(spacing: 0) {
				bandName()

				bandImage()

				bandDescription()
			}
			.overlay(RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(choosenBand ? Color.irfcYellow : Color.lightGray,
				        lineWidth: choosenBand ? 5 : 4)
			)
			.cornerRadius(cornerRadius)
		}
	}

	private func bandName() -> some View {
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

	private func bandImage() -> some View {
		GeometryReader { geo in
			Image("irfcMap")
				.resizable()
				.scaledToFill()
				.frame(width: geo.size.width, height: geo.size.height)
				.clipped()
		}
	}

	private func bandDescription() -> some View {
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
			.frame(maxWidth: 300, maxHeight: 250)
			.padding()
	}
}
