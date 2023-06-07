//
//  FilterButtonView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 05.06.23.
//

import SwiftUI

struct FilterButtonView: View {
	var buttonText: String
	@Binding var isActive: Bool

	var body: some View {
		Button(action: {
			isActive = true
			print("\(buttonText) was filtered")
		}) {
			Text(buttonText)
				.font(.headline)
				.foregroundColor(isActive ? Color.black : Color.primary)
				.padding(.vertical, 8)
				.padding(.horizontal, 24)
				.background(isActive ? Color.irfcYellow : Color.clear)
				.cornerRadius(20)
				.overlay(
					RoundedRectangle(cornerRadius: 20)
						.stroke(Color.gray, lineWidth: 1)
						.shadow(radius: 3, x: 0, y: 2)
				)
		}
	}
}

struct FilterButtonView_Previews: PreviewProvider {
	@State static var activeFilter = false

	static var previews: some View {
		FilterButtonView(buttonText: "Filter", isActive: $activeFilter)
	}
}
