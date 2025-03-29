//
//  PlaylistView.swift
//  IronRoadForChildren
//
//  Created by Altendorfer Laurenz on 28.03.2025.
//

import SwiftUI

struct PlaylistView: View {
    var body: some View {
        VStack {
            SpotifyPlaylistWebView()
                .cornerRadius(8)
                .padding()
        }
        .navigationTitle("Playlist")
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlaylistView()
        }
    }
}

