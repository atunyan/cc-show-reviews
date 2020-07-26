
import Foundation

func isoDateFormatter(dateString: String) -> String {
	let isoDateFormatter = ISO8601DateFormatter()
	let date = isoDateFormatter.date(from: dateString)

	let dateFormatter = DateFormatter()
	dateFormatter.dateStyle = .long
	dateFormatter.timeStyle = .none
	dateFormatter.locale = Locale(identifier: "en_US_POSIX")

	return dateFormatter.string(from: (date ?? Date()))
}
