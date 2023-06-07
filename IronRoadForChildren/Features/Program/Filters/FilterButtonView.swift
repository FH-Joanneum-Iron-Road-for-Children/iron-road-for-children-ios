//
//  FilterButtonView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 05.06.23.
//

import CoreUI
import SwiftUI

struct FilterButtonView: View {
	var buttonText: String
	@Binding var isActive: Bool

	var body: some View {
		Button(buttonText) {
			isActive.toggle()
			print("\(buttonText) was filtered")
		}
		.padding()
		.ifTrue(isActive) { view in
			view.buttonStyle(IrfcYellowRoundedButton())
		}
		.ifTrue(!isActive) { view in
			view.buttonStyle(IrfcWhiteRoundedButton())
		}
	}
}

struct FilterButtonView_Previews: PreviewProvider {
	@State static var activeFilter = false

	static var previews: some View {
		FilterButtonView(buttonText: "Filter", isActive: $activeFilter)
	}
}
