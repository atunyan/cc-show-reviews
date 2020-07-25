import Foundation

protocol EndpointUrlHelping {
	var baseUrl: URL { get }
	func reviewsUrl(with path: String, tourId: String) -> URL
}

struct EndpointUrlHelper: EndpointUrlHelping {
	let baseUrl: URL

	func reviewsUrl(with path: String, tourId: String) -> URL {
		let endpoint = baseUrl
			.appendingPathComponent("/activities/\(tourId)")
			.appendingPathComponent(path)

		return urlQuery(urlString: endpoint.absoluteString)
	}

	func urlQuery(urlString: String) -> URL {
		let urlQuery = URLComponents(string: urlString)
		guard let url = urlQuery?.url else {
			fatalError("\(String(describing: urlQuery?.string)) is not valid url")
		}

		return url
	}

}

extension EndpointUrlHelper {
	static var `default`: EndpointUrlHelping {
		return EndpointUrlHelper(baseUrl: Environment.gatewayUrl)
	}
}
