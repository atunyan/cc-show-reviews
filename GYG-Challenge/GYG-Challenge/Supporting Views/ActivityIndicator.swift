//
//  ActivityIndicator.swift
//  GYG-Challenge
//


import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

	@Binding var shouldAnimate: Bool

	func makeUIView(context: Context) -> UIActivityIndicatorView {
		let indicatorView = UIActivityIndicatorView(style: .large)
		return indicatorView
	}

	func updateUIView(_ uiView: UIActivityIndicatorView,
					  context: Context) {
		if self.shouldAnimate {
			uiView.startAnimating()
		} else {
			uiView.stopAnimating()
		}
	}
}

struct TestContentView: View {

	@State var shouldAnimate = false

	var body: some View {
		VStack {
			ActivityIndicator(shouldAnimate: $shouldAnimate)
				.background(Color.red)
			Button(action: {
				self.shouldAnimate = !self.shouldAnimate
			}, label: {
				Text("Start/Stop")
					.foregroundColor(Color.white)
			})
				.background((Color.blue))
		}
		.padding()
	}
}

struct TestContentView_Previews: PreviewProvider {
	static var previews: some View {
		TestContentView()
	}
}
