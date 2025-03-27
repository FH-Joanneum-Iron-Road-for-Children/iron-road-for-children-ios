// Copyright © 2025 IRFC

import AVFoundation
import AVKit
import SwiftUI
import UIKit

// https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4

struct VideoPlayerView: UIViewRepresentable {
	let url: URL

	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: .zero)

		// Create player
		let player = AVPlayer(url: url)
		let playerLayer = AVPlayerLayer(player: player)
		playerLayer.videoGravity = .resizeAspect
		playerLayer.frame = view.bounds
		view.layer.addSublayer(playerLayer)

		// Add observer to handle resizing
		view.layer.addObserver(context.coordinator,
		                       forKeyPath: "bounds",
		                       options: .new,
		                       context: nil)

		// Store player and layer in coordinator
		context.coordinator.player = player
		context.coordinator.playerLayer = playerLayer

		// Start playback
		player.play()

		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {
		context.coordinator.playerLayer?.frame = uiView.bounds
	}

	func makeCoordinator() -> Coordinator {
		Coordinator()
	}

	class Coordinator: NSObject {
		var player: AVPlayer?
		var playerLayer: AVPlayerLayer?

		override func observeValue(forKeyPath keyPath: String?,
		                           of object: Any?,
		                           change _: [NSKeyValueChangeKey: Any]?,
		                           context _: UnsafeMutableRawPointer?)
		{
			if keyPath == "bounds" {
				if let layer = object as? CALayer {
					playerLayer?.frame = layer.bounds
				}
			}
		}

		deinit {
			player?.pause()
			player = nil
		}
	}
}
