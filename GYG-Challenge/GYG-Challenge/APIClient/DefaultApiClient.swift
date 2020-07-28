import Foundation

protocol  ApiClient {
	func fetchReviews(with tourId: Int, limit: Int?, offset: Int?, sortQuery: String?, _ onComplete: @escaping (Result<Reviews, NetworkError>) -> Void)
}

private enum Path: String {
	case reviews = "/reviews"
}

struct DefaultApiClient: ApiClient {

	let service: NetworkAdaptor
	let endpoint: EndpointUrlHelping

	func fetchReviews(with tourId: Int, limit: Int?, offset: Int?, sortQuery: String?, _ onComplete: @escaping (Result<Reviews, NetworkError>) -> Void) {

		let url = endpoint.reviewsUrl(with: Path.reviews.rawValue, tourId: tourId, limit: limit, offset: offset, sortQuery: sortQuery)

		service.request(url) { result in
			switch result {
			case .success(let data, _):
				do {
					let result = try JSONDecoder().decode(Reviews.self, from: data)
					onComplete(.success(result))
				} catch {
					onComplete(.failure(NetworkError.invalidJSON))
				}
			case .failure(let error):
				onComplete(.failure(NetworkError.network(description: error.localizedDescription)))
			}
		}
	}
}

