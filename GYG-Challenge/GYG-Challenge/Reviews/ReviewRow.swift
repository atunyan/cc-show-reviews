//
//  ReviewRow.swift
//  GYG-Challenge
//

import SwiftUI
import Combine

struct ReviewRow: View {

	@ObservedObject var viewModel: ReviewViewModel

    var body: some View {
		VStack(alignment: .leading) {
			Text(viewModel.date)
				.font(.subheadline)
				.fontWeight(.semibold)
				.foregroundColor(Color.gray)
				.padding(.bottom, 5)

			Text(viewModel.title)
				.font(.headline)
				.fontWeight(.bold)

			Rating(value: viewModel.rating).padding(.bottom, 5)

			Text(viewModel.message)
				.font(.caption)
				.fontWeight(.regular)
				.foregroundColor(Color.black)
				.padding(.bottom, 10)

			HStack(alignment: .center) {
				CircleImage(image: viewModel.userPhoto)
				VStack(alignment: .leading) {
					Text("reviewed by")
						.font(.footnote)
					Text(viewModel.userInfo)
				}
			}
		}
		.padding()
	}
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
		ReviewRow(viewModel: ReviewViewModel(model: Review.defualt))
    }
}
