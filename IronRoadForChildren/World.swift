//
//  World.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

var world = World()

struct World {
	private var serverURLComponents: URLComponents

	var serverURL: URL {
		serverURLComponents.url!
	}

	init() {
		serverURLComponents = URLComponents()
		serverURLComponents.scheme = "https"
		serverURLComponents.host = "backend.irfc-test.fh-joanneum.at"
	}

	func serverUrlWith(path: String) -> URL {
		var components = serverURLComponents
		components.path = path
		return components.url!
	}
}
