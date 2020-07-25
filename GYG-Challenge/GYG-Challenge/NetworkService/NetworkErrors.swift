
enum Errors: Error {
  case invalidJSON
  case network(description: String)
  case unknown
}

extension Errors {
  var errorDescription: String {
    switch self {
    case .invalidJSON:
      return "Invalid JSON"
    case .network(description: let description):
      return description
    case .unknown:
      return "Unknown error"
    }
  }
}
