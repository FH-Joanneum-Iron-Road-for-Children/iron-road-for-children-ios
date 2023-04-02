@testable import Networking
import XCTest

final class NetworkingTests: XCTestCase {
	func testGetRequest() async throws {
		let (body, response) = try await URLSession.shared.data(
			.get,
			from: URL(string: "https://postman-echo.com/get")!,
			responseType: TestModel.self
		)

		XCTAssertEqual(response.statusCode, 200)
		XCTAssertEqual(body.url, "https://postman-echo.com/get")
	}

	private struct TestModel: Codable {
		let url: String
	}
}
