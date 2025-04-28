// Copyright © 2025 IRFC

import SwiftUI
import WebKit



struct SpotifyPlaylistWebView: UIViewRepresentable {
    let playlistID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlString = "https://open.spotify.com/embed/playlist/\(playlistID)"
        if let url = URL(string: urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
}
