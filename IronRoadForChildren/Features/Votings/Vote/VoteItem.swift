// Copyright © 2023 IRFC

import CoreUI
import SwiftUI

struct VoteItem: View {
	var event: Event
	var choosenBand: Bool
	var clickable: Bool
	var click: () -> Void

	private var cornerRadius: CGFloat = 20

	public init(event: Event, choosenEvent: Bool, clickable: Bool, click: @escaping () -> Void) {
		self.event = event
		choosenBand = choosenEvent
		self.clickable = clickable
		self.click = click
	}

	var body: some View {
		Button {
			guard clickable else { return }
			click()
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
		.disabled(!clickable)
	}

	private func bandName() -> some View {
		HStack {
			Text(event.title)
				.font(.title)
				.fontWeight(.black)
				.foregroundColor(.primary)
				.lineLimit(2)
				.multilineTextAlignment(.leading)
				.padding()

			Spacer()
		}
	}

	@ViewBuilder
	private func bandImage() -> some View {
		if let imageUrl = URL(string: event.picture.path) {
			GeometryReader { geo in
				AsyncImage(url: imageUrl) { image in
					image.resizable()
						.scaledToFill()
						.frame(width: geo.size.width, height: geo.size.height)
						.clipped()
				} placeholder: {
					ProgressView()
				}
			}
		}
	}

	private func bandDescription() -> some View {
		HStack {
			Text(event.eventInfo.infoText)
				.font(.headline)
				.foregroundColor(.secondary)
				.padding()

			Spacer()
		}
	}
}

struct VoteBandItem_Previews: PreviewProvider {
	static var previews: some View {
		VoteItem(event: Mocks.event, choosenEvent: true, clickable: true, click: {})
			.frame(maxWidth: 300, maxHeight: 250)
			.padding()
	}
}
