import Foundation

struct Environment {

	static var gatewayUrl: URL {
		let str = "https://travelers-api.getyourguide.com"
		guard let url = URL(string: str) else {
			fatalError("\(str) is not valid url")
		}
		return url
	}

}
