// Copyright © 2025 IRFC

import Foundation
import UIKit

class ImageCache {
	static let shared = ImageCache()
	private let cache = NSCache<NSString, UIImage>()

	private init() {
		// Configure cache capacity
		cache.countLimit = 100 // Maximum number of objects
		cache.totalCostLimit = 50 * 1024 * 1024 // 50MB limit
	}

	func getImage(for key: NSString) -> UIImage? {
		return cache.object(forKey: key)
	}

	func setImage(_ image: UIImage, for key: NSString) {
		cache.setObject(image, forKey: key)
	}

	func clear() {
		cache.removeAllObjects()
	}
}
