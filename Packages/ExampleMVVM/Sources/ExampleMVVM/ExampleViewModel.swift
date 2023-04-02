//
//  ExampleViewModel.swift
//
//
//  Created by Alexander Kauer on 12.03.23.
//

import Combine
import Foundation
import Networking

@MainActor
class ExampleViewModel: ObservableObject {
	@Published var model: ExampleModel?
	@Published var errorText: String?
	@Published var isLoading: Bool = false

	func loadTextFromServer() {
		Task {
			await loadTextFromServer()
		}
	}

	func loadTextFromServer() async {
		do {
			isLoading = true

			let url = URL(string: "https://postman-echo.com/get")! // normally get URL from config
			let (body, response) = try await URLSession.shared.data(.get, from: url, responseType: ExampleModel.self)

			guard response.statusCode == 200 else { throw NetworkingError.wrongStatusCode }

			model = body

			isLoading = false

		} catch {
			errorText = error.localizedDescription
			isLoading = false
		}
	}
}
