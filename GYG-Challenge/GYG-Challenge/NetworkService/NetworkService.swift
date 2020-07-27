
import Foundation

struct NetworkService: NetworkAdaptor {

	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func request(_ url: URL,
							 method: RequestHTTPMethod = .get,
							 parameters: [String : Any]? = nil,
							 headers: [String: String]? = nil,
							 onComplete: @escaping (Result<(Data, URLResponse), Error>) -> Void) {

		var request = URLRequest(url: url,
														 cachePolicy: .reloadIgnoringLocalCacheData,
														 timeoutInterval: 30)
		request.httpMethod = method.rawValue

		session.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				if let data = data, let response = response {
					onComplete(.success((data, response)))
				}
				if let error = error {
					onComplete(.failure(error))
				}
			}
		}.resume()
	}
}

