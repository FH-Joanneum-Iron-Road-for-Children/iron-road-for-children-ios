//
//  OSBoolExtensions.swift
//
//
//  Created by Alexander Kauer on 25.04.23.
//

import Foundation

public extension Bool {
	static var iOS15: Bool {
		guard #available(iOS 15, *) else {
			return true
		}

		return false
	}

	static var iOS16: Bool {
		guard #available(iOS 16, *) else {
			return true
		}

		return false
	}
}
