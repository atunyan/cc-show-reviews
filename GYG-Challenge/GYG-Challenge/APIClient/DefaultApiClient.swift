import Foundation

protocol  ApiClient {
	func fetchReviews(with id: Int, _ onComplete: @escaping (Reviews?, String?) -> Void)
}

private enum Path: String {
	case reviews = "/reviews"
}

struct DefaultApiClient: ApiClient {

	let service: NetworkAdaptor
	let endpoint: EndpointUrlHelping

	func fetchReviews(with id: Int, _ onComplete: @escaping (Reviews?, String?) -> Void) {

		let url = endpoint.reviewsUrl(with: Path.reviews.rawValue, tourId: String(id))

		service.request(url) { (data, error) in
			do {
				guard let data = data else {
					if let error = error {
						DispatchQueue.main.async {
							onComplete(nil, Errors.network(description: error.localizedDescription).errorDescription)
						}
					}
					return
				}
				let result = try JSONDecoder().decode(Reviews.self, from: data)

				DispatchQueue.main.async {
					onComplete(result, nil)
				}
			} catch {
				DispatchQueue.main.async {
					onComplete(nil, Errors.unknown.localizedDescription)
				}
			}
		}
	}
}

