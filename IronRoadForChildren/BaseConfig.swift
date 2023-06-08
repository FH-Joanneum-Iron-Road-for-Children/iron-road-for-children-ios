//
//  BaseConfig.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 07.06.23.
//

import Foundation

protocol BaseConfig {
	var serverURL: URL { get }
	var serverURLComponents: URLComponents { get }
}
