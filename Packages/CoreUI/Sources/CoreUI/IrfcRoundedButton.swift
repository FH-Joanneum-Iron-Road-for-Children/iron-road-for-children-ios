//
//  IrfcRoundedButton.swift
//
//
//  Created by Alexander Kauer on 24.03.23.
//

import SwiftUI

public struct IrfcYellowRoundedButton: ButtonStyle {
	public init() {}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(8)
			.foregroundColor(.black)
			.padding(.horizontal, 16)
			.background(Color.irfcYellow)
			.clipShape(Capsule())
			.shadow(radius: 3)
			.opacity(configuration.isPressed ? 0.7 : 1.0)
	}
}

public struct IrfcWhiteRoundedButton: ButtonStyle {
	@Environment(\.colorScheme) private var colorScheme

	public init() {}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(.textColor)
			.padding(8)
			.padding(.horizontal, 16)
			.background(
				RoundedRectangle(cornerRadius: 32)
					.fill(Color.whiteBlack)
					.ifTrue(colorScheme == .light) { view in
						view.shadow(radius: 3)
					}
			)
			.ifTrue(colorScheme == .dark) { view in
				view.overlay(
					RoundedRectangle(cornerRadius: 32)
						.stroke(Color.textColor, lineWidth: 1)
				)
			}
			.opacity(configuration.isPressed ? 0.7 : 1.0)
	}
}

struct IrfcButton_Previews: PreviewProvider {
	static var previews: some View {
		HStack(spacing: 16) {
			Button("Konzert") {}
				.buttonStyle(IrfcYellowRoundedButton())

			Button("Konzert") {}
				.buttonStyle(IrfcWhiteRoundedButton())
		}
	}
}
