//
//  MapView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 06.06.23.
//

import Foundation
import SwiftUI

struct MapView: View {
	var body: some View {
		List {
			Section(header: Text("")) {
				NavigationLink("IRFC Karte", destination: EventMapView())
			}

			Section(header: Text("Ausfahrten")) {
				NavigationLink("Ausfahrt 1", destination: EventMapView())
				NavigationLink("Ausfahrt 2", destination: EventMapView())
				NavigationLink("Ausfahrt 3", destination: EventMapView())
			}
		}
		.navigationTitle("Karten 🗺️")
	}
}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MapView()
		}
	}
}
