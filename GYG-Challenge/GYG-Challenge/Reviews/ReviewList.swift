//
//  ContentView.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/24/20.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import SwiftUI
import Combine

struct ReviewList: View {

	@ObservedObject var viewModel: ReviewListViewModel

	var body: some View {
		VStack {
			if viewModel.shouldShowActivityIndicator {
				ActivityIndicator(shouldAnimate: $viewModel.shouldShowActivityIndicator)
			} else {
				NavigationView {
					List(0..<viewModel.reviewViewModels.count, id: \.self) { index in
						ReviewRow(viewModel: self.viewModel.reviewViewModels[index]
						)
						.onAppear(perform: { self.viewModel.fetchMoreReviewIfEndIndex(index)
						})
					}
					.navigationBarTitle("Reviews")
				}
			}
		}
	}
}

struct ReviewList_Previews: PreviewProvider {
	static var previews: some View {
		ReviewList(viewModel: ReviewListViewModel(client: ApiClientMock(), tourId: 0))
	}
}
