// Copyright © 2025 IRFC

import SwiftUI
import WebKit

struct SpotifyPlaylistWebView: UIViewRepresentable {
    // let playlistID: String = "5pxt5SY01aGmEnzPiCJzP7?si=b_VTAha-SRKuI-mHoAbLKg&pi=qsDQZhwmTKmE5"
    // let playlistID: String = "09NuEOtv93hJnlYDXmUs7R"
    let playlistID: String = "7vchJ7dIBuzGd8aDC1NJpW"
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlString = "https://open.spotify.com/embed/playlist/\(playlistID)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
