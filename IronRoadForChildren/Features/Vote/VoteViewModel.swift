//
//  VoteViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 25.04.23
//

import Foundation
import UIKit

class VoteViewModel: ObservableObject {
	@Published var alreadyVoted = world.keychain.alreadyVoted

	var deviceID: String? {
		UIDevice.current.identifierForVendor?.uuidString
	}

	func trigger() {
		print(deviceID)

		world.keychain.alreadyVoted = true
		alreadyVoted = world.keychain.alreadyVoted
	}
}
