//
//  World.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

var world = World()

struct World {
	private(set) var config = Config()

	func serverUrlWith(path: String) -> URL {
		var components = config.serverURLComponents
		components.path = path
		return components.url!
	}
}
