//
//  Config.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 07.06.23.
//

import Foundation

struct Config: BaseConfig {
	private(set) var serverURLComponents: URLComponents

	var serverURL: URL {
		serverURLComponents.url!
	}

	init() {
		serverURLComponents = URLComponents()
		serverURLComponents.scheme = "https"
		serverURLComponents.host = "backend.irfc.fh-joanneum.at"
	}
}
