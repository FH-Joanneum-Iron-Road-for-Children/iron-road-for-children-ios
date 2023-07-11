// Copyright © 2023 IRFC

import Foundation

protocol BaseConfig {
	var serverURL: URL { get }
	var serverURLComponents: URLComponents { get }
}
