//
//  MapView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.03.23.
//

import SwiftUI

struct MapView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .gesture(MagnificationGesture()
                .onChanged { value in
                    self.scale = value.magnitude
                }
            )
            .scaleEffect(scale)
        Spacer()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
