//
//  MapView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.03.23.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Karte")
                    .font(.largeTitle)
                    .padding(.vertical, 60)
                    .padding(.leading, 40)
                Spacer()
            }
            Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity)
                .padding(.horizontal, 20)
            Spacer()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
