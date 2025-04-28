// Copyright © 2025 IRFC

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    @State private var isPlaying: Bool = false
    @State private var player: AVPlayer
    private let videoURL: URL

    init(videoURL: URL) {
        self.videoURL = videoURL
        _player = State(initialValue: AVPlayer(url: videoURL))
    }

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .aspectRatio(16 / 9, contentMode: .fill)
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

            // Show the play button overlay when video is not playing
            if !isPlaying {
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

#Preview {
    VideoPlayerView(
        videoURL: URL(
            string:
            "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"
        )!)
}
