//
//  World.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

var world = World()

struct World {
	private let config = Config()

	let keychain = KeychainWrapper()

	func serverUrlWith(path: String) -> URL {
		var components = config.serverURLComponents
		components.path = path
		return components.url!
	}
}

public extension Bundle {
	var appName: String { getInfo("CFBundleName") }
	var displayName: String { getInfo("CFBundleDisplayName") }
	var language: String { getInfo("CFBundleDevelopmentRegion") }
	var identifier: String { getInfo("CFBundleIdentifier") }
	var copyright: String { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }

	var appBuild: String { getInfo("CFBundleVersion") }
	var appVersionLong: String { getInfo("CFBundleShortVersionString") }
	var appVersionShort: String { getInfo("CFBundleShortVersion") }

	fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
