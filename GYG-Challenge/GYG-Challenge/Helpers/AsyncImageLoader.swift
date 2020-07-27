
import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {

	@Published private(set) var uiImage: UIImage?

	private var cancellable: AnyCancellable?

	func load(url: URL) {
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map{ UIImage(data: $0.data) }
			.replaceError(with: nil)
			.receive(on: DispatchQueue.main)
			.assign(to: \.uiImage, on: self)
	}

	func cancel() {
		cancellable?.cancel()
	}
}
