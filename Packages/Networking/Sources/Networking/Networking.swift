import Foundation

public extension URLSession {
	/**
	 Sends HTTP request to a server and does the encoding/decoding of the Codable objects
	 */
	func data<R>(
		_ httpMethod: HTTPMethod,
		from url: URL,
		withHeaders _: [String: String]? = nil,
		responseType: R.Type
	) async throws -> (R, HTTPURLResponse) where R: Decodable {
		let placeholder: String? = nil
		return try await data(httpMethod, from: url, withRequestBody: placeholder, responseType: responseType)
	}

	/**
	 Sends HTTP request to a server and does the encoding/decoding of the Codable objects
	 */
	func data<R, B: Encodable>(
		_ httpMethod: HTTPMethod,
		from url: URL,
		withHeaders _: [String: String]? = nil,
		withRequestBody requestBody: B? = nil,
		responseType _: R.Type
	) async throws -> (R, HTTPURLResponse) where R: Decodable {
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue

		if let requestBody = requestBody {
			request.httpBody = try JSONEncoder().encode(requestBody)
		}

		let (data, response) = try await URLSession.shared.data(for: request)

		guard let urlResponse = response as? HTTPURLResponse else {
			throw NetworkingError.httpURLResponseParseError
		}

		let responseBody = try JSONDecoder().decode(R.self, from: data)

		return (responseBody, urlResponse)
	}

	func dataArray<R>(
		_ httpMethod: HTTPMethod,
		from url: URL,
		withHeaders _: [String: String]? = nil,
		responseType: R.Type
	) async throws -> ([R], HTTPURLResponse) where R: Decodable {
		let placeholder: String? = nil
		return try await dataArray(httpMethod, from: url, withRequestBody: placeholder, responseType: responseType)
	}

	func dataArray<R: Decodable, B: Encodable>(
		_ httpMethod: HTTPMethod,
		from url: URL,
		withHeaders _: [String: String]? = nil,
		withRequestBody requestBody: B? = nil,
		responseType _: R.Type
	) async throws -> ([R], HTTPURLResponse) where R: Decodable {
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue

		if let requestBody = requestBody {
			request.httpBody = try JSONEncoder().encode(requestBody)
		}

		let (data, response) = try await URLSession.shared.data(for: request)

		guard let urlResponse = response as? HTTPURLResponse else {
			throw NetworkingError.httpURLResponseParseError
		}

		let responseBody = try JSONDecoder().decode([R].self, from: data)

		return (responseBody, urlResponse)
	}
}

public enum NetworkingError: Error {
	case httpURLResponseParseError
	case wrongStatusCode
}

public enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}
