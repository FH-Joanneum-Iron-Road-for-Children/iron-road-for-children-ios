// Copyright © 2025 IRFC

import AVKit
import SwiftUI

struct VideoPlayerView: View {
	@State private var isPlaying: Bool = false
	@State private var player: AVPlayer
	@State private var isLoading = true
	@State private var altText: String = ""
	@State private var errorMessage: String? = nil
	private let apiEndpoint: URL

	init(apiEndpoint: URL) {
		self.apiEndpoint = apiEndpoint
		// Initialize with an empty player
		_player = State(initialValue: AVPlayer())
	}

	var body: some View {
		ZStack {
			if let errorMessage = errorMessage {
				Text(errorMessage)
					.foregroundColor(.red)
					.padding()
					.background(Color.black.opacity(0.7))
					.cornerRadius(8)
			} else {
				VideoPlayer(player: player)
					.aspectRatio(16 / 9, contentMode: .fill)
					.accessibilityLabel(altText)
					.onAppear {
						setupPlayerObservers()
					}
					.onDisappear {
						// Pause the video when view disappears
						player.pause()
						isPlaying = false
						// Remove observers
						NotificationCenter.default.removeObserver(self)
					}

				// Show loading indicator while fetching data
				if isLoading {
					ProgressView()
				}
				// Show the play button overlay when video is not playing and not loading
				else if !isPlaying {
					Button(action: {
						player.play()
						isPlaying = true
					}) {
						Image(systemName: "play.fill")
							.resizable()
							.frame(width: 50, height: 50)
							.foregroundColor(.yellow)
					}
				}
			}
		}
		.onAppear {
			loadVideo()
		}
	}

	private func loadVideo() {
		Task {
			do {
				print("Fetching from URL: \(apiEndpoint.absoluteString)")

				let (data, response) = try await URLSession.shared.data(from: apiEndpoint)

				// Check HTTP status code
				if let httpResponse = response as? HTTPURLResponse,
				   !(200 ... 299).contains(httpResponse.statusCode)
				{
					throw NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
				}

				// Convert data to string for debugging
				if let dataString = String(data: data, encoding: .utf8) {
					print("Received data: \(dataString)")
				}

				// Try to decode the JSON
				let videoInfo = try JSONDecoder().decode(VideoInfo.self, from: data)
				print("Successfully decoded JSON: \(videoInfo)")

				// Create URL from path
				guard let videoURL = URL(string: videoInfo.path) else {
					throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
				}

				// Update UI on main thread
				await MainActor.run {
					self.player = AVPlayer(url: videoURL)
					self.altText = videoInfo.altText
					self.isLoading = false
				}
			} catch {
				print("Error loading video: \(error)")
				await MainActor.run {
					self.errorMessage = "Error loading video: \(error.localizedDescription)"
					self.isLoading = false
				}
			}
		}
	}

	private func setupPlayerObservers() {
		// Add observer to know when video finishes
		NotificationCenter.default.addObserver(
			forName: .AVPlayerItemDidPlayToEndTime,
			object: player.currentItem,
			queue: .main
		) { _ in
			// Reset video to beginning when finished
			player.seek(to: CMTime.zero)
			isPlaying = false
		}
		// Add observer for play/pause status
		NotificationCenter.default.addObserver(
			forName: .AVPlayerItemPlaybackStalled,
			object: player.currentItem,
			queue: .main
		) { _ in
			isPlaying = false
		}
	}
}

struct VideoInfo: Codable {
	let videoId: Int
	let altText: String
	let path: String
}
