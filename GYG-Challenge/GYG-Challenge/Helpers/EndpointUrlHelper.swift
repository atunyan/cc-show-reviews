import Foundation

protocol EndpointUrlHelping {
	var baseUrl: URL { get }
	func reviewsUrl(with path: String,
					tourId: Int,
					limit: Int?,
					offset: Int?,
					sortQuery: String?) -> URL
}

struct EndpointUrlHelper: EndpointUrlHelping {
	let baseUrl: URL

	func reviewsUrl(with path: String, tourId: Int, limit: Int?, offset: Int?, sortQuery: String?) -> URL {
		let endpoint = baseUrl
			.appendingPathComponent("/activities/\(tourId)")
			.appendingPathComponent(path)

		return urlQuery(urlString: endpoint.absoluteString,
						limit: limit,
						offset: offset,
						sortQuery: sortQuery)
	}

	func urlQuery(urlString: String, limit: Int?, offset: Int?, sortQuery: String?) -> URL {

		var urlQuery = URLComponents(string: urlString)
		urlQuery?.queryItems = []

		if let limit = limit {
			urlQuery?.queryItems?.append(URLQueryItem(name:"limit", value: "\(limit)"))
		}

		if let offset = offset {
			urlQuery?.queryItems?.append(URLQueryItem(name:"offset", value: "\(offset)"))
		}

		if let sortQuery = sortQuery {
			urlQuery?.queryItems?.append(URLQueryItem(name:"sort", value: sortQuery))
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
