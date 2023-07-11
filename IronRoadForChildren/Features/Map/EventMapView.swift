// Copyright © 2023 IRFC

import SwiftUI

struct EventMapView: View {
	var body: some View {
		if let irfcMap = UIImage(named: "irfcMap") {
			PhotoDetailView(image: irfcMap)
		} else {
			Text("Karte konnte nicht geladen werden")
		}
	}
}

struct EventMapView_Previews: PreviewProvider {
	static var previews: some View {
		EventMapView()
	}
}
