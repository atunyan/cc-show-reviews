import Foundation

protocol EndpointUrlHelping {
	var baseUrl: URL { get }
	func reviewsUrl(with path: String, tourId: Int, limit: Int?, offset: Int?) -> URL
}

struct EndpointUrlHelper: EndpointUrlHelping {
	let baseUrl: URL

	func reviewsUrl(with path: String, tourId: Int, limit: Int?, offset: Int?) -> URL {
		let endpoint = baseUrl
			.appendingPathComponent("/activities/\(tourId)")
			.appendingPathComponent(path)

		return urlQuery(urlString: endpoint.absoluteString,
						limit: limit, offset: offset)
	}

	func urlQuery(urlString: String, limit: Int?, offset: Int?) -> URL {

		var urlQuery = URLComponents(string: urlString)
		
		if let limit = limit {
			urlQuery?.queryItems = [URLQueryItem(name:"limit", value: "\(limit)")]
		}

		if let offset = offset {
			urlQuery?.queryItems = [URLQueryItem(name: "offset", value: "\(offset)")]
		}

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
