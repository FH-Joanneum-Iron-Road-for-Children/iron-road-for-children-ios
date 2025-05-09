// Copyright © 2025 IRFC
//
//  PlaylistView.swift
//  IronRoadForChildren
//
//  Created by Altendorfer Laurenz on 28.03.2025.
//

import SwiftUI
import Networking
import WebKit

struct Playlist: Codable, Identifiable {
    let playlistId: Int
    let title: String
    let spotifyPlaylistId: String

    var id: Int { playlistId }
}

struct PlaylistView: View {
    @State private var playlistID: String = ""
    @State var playlist: [Playlist] = []
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            SpotifyPlaylistWebView(playlistID: playlistID)
                .onAppear {
                    Task {
                        await loadPlaylistID()
    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .navigationTitle("Playlist")
        }
    }
    
    @MainActor
    private func loadPlaylistID() async {
        let url = world.serverUrlWith(path: "/api/playlist")
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let http = response as? HTTPURLResponse else {
                        errorMessage = "Ungültige Antwort"
                        return
                    }
                    guard (200..<300).contains(http.statusCode) else {
                        errorMessage = "HTTP \(http.statusCode)"
                        return
                    }
                    let playlist = try JSONDecoder().decode(Playlist.self, from: data)
                    playlistID = playlist.spotifyPlaylistId
                } catch {
                    errorMessage = error.localizedDescription
                }
    }
}
