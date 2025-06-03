// Copyright © 2025 IRFC

import AVKit
import Combine
import SwiftUI

struct HomeView: View {
	@StateObject private var countdownViewModel = CountdownViewModel()
	

	var body: some View {
		VStack(spacing: 4) {
			VideoPlayerView(
				apiEndpoint: world.serverUrlWith(path: "/api/intro-video")
			)
			countdownView
			SocialMediaView()
		}
	}

	private var countdownView: some View {
		ZStack {
			Color(red: 0.9, green: 0.3, blue: 0.3)

			ZStack {
				if let image = UIImage(named: "countdownShine") {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.scaleEffect(1.2)
						.frame(height: 120)
						.clipped()
						.opacity(0.1)
				}

				VStack(spacing: 0) {
					HStack(spacing: 0) {
						CountdownItem(
							value: countdownViewModel.days, label: "DAYS"
						)
						CountdownItem(
							value: countdownViewModel.hours, label: "HOURS"
						)
						CountdownItem(
							value: countdownViewModel.minutes, label: "MIN."
						)
						CountdownItem(
							value: countdownViewModel.seconds, label: "SEC."
						)
					}
					.padding(.vertical)
					.padding(.horizontal, 24)
					.overlay(
						Rectangle()
							.frame(height: 3)
							.foregroundColor(.white)
							.padding(.horizontal, 40)
							.offset(y: 14),
						alignment: .center
					)
				}
			}
		}
	}

	struct CountdownItem: View {
		var value: Int
		var label: String

		var body: some View {
			VStack(spacing: 8) {
				Text("\(value)")
					.font(.system(size: 50, weight: .bold, design: .rounded))
					.foregroundColor(.yellow)
					.minimumScaleFactor(0.5)

				Text(label)
					.font(.system(size: 20, weight: .bold))
					.foregroundColor(.yellow)
					.minimumScaleFactor(0.7)
			}
			.frame(maxWidth: .infinity)
		}
	}
}

#Preview {
	HomeView()
}
