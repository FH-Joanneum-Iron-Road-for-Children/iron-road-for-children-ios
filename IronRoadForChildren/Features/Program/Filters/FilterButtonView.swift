// Copyright © 2023 IRFC

import CoreUI
import SwiftUI

struct FilterButtonView: View {
	var buttonText: String
	var isActive: Bool
	var click: () -> Void

	var body: some View {
		Button(buttonText) {
			click()
		}
		.padding(.vertical)
		.padding(.leading)
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
		FilterButtonView(buttonText: "Filter", isActive: activeFilter) {}
	}
}
