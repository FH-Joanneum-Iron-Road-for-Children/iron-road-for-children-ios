//
//  URLRequestExtension.swift
//
//
//  Created by Alexander Kauer on 08.07.23.
//

import Foundation

extension URLRequest {
	mutating func applyHttpMethod(_ httpMethod: HTTPMethod) {
		self.httpMethod = httpMethod.rawValue
	}

	mutating func applyHeaders(_ headers: [String: String]? = nil) {
		setValue("application/json", forHTTPHeaderField: "Content-Type")

		guard let headers = headers else { return }
		headers.forEach { header in
			self.setValue(header.value, forHTTPHeaderField: header.key)
		}
	}

	mutating func applyRequestBody(_ requestBody: Encodable?) throws {
		guard let requestBody = requestBody else { return }
		httpBody = try JSONEncoder().encode(requestBody)
	}
}
