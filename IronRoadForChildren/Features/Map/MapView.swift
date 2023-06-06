//
//  MapView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 06.06.23.
//

import Foundation
import SwiftUI

struct MapView: View {
	let vespasURL = URL(string: "https://www.google.com/maps/d/u/0/viewer?mid=1sUkiDBKmKDcsjcoOFktF1HYvazYVAxtx&ehbc=2E312F&ll=47.383043220666224%2C15.028895000000002&z=13")!
	let usCarsURL = URL(string: "https://www.google.com/maps/d/u/0/viewer?mid=1bkIAT_Zqcn_NkDMFGe8MFf_d1S_z0chh&ehbc=2E312F&ll=47.458139643821866%2C14.986134999999994&z=12")!
	let bikesURL = URL(string: "https://www.google.com/maps/d/viewer?mid=1bkIAT_Zqcn_NkDMFGe8MFf_d1S_z0chh&usp=sharing")!

	var body: some View {
		List {
			Section(header: Text("")) {
				NavigationLink("IRFC Karte", destination: EventMapView())
			}

			Section(header: Text("Ausfahrten")) {
				Link(destination: vespasURL) {
					HStack {
						Text("Ausfahrt VESPAS")
						Spacer()
						Image(systemName: "chevron.right")
							.imageScale(.small)
							.font(.body.weight(.semibold))
					}
				}

				Link(destination: usCarsURL) {
					HStack {
						Text("Ausfahrt US-CARS")
						Spacer()
						Image(systemName: "chevron.right")
							.imageScale(.small)
							.font(.body.weight(.semibold))
					}
				}

				Link(destination: bikesURL) {
					HStack {
						Text("Ausfahrt BIKES")
						Spacer()
						Image(systemName: "chevron.right")
							.imageScale(.small)
							.font(.body.weight(.semibold))
					}
				}
			}
		}
	}
}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MapView()
		}
	}
}
