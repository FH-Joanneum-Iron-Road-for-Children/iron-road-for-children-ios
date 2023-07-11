// Copyright © 2023 IRFC

import CoreUI
import Foundation
import SwiftUI

struct ErrorRetryView: View {
	var title: String = "Es ist ein Fehler aufgetreten."
	var desc: String? = nil
	var retry: (() -> Void)? = nil

	var body: some View {
		VStack {
			Text(title)
				.multilineTextAlignment(.center)
				.padding(.horizontal)
				.padding(.bottom)

			if let desc = desc {
				Text(desc)
					.multilineTextAlignment(.center)
					.font(.caption)
					.padding(.horizontal)
					.padding(.horizontal)
			}

			if let retry = retry {
				Button("Erneut versuchen") {
					retry()
				}
				.buttonStyle(IrfcYellowRoundedButton())
				.padding(.horizontal)
				.padding(.top)
			}
		}
	}
}
