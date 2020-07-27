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

	@ObservedObject var listViewModel: ReviewListViewModel

	var body: some View {
		VStack {
			if listViewModel.isLoading {
				ActivityIndicator(shouldAnimate: $listViewModel.isLoading)
			} else {
				NavigationView {
			List(0..<listViewModel.reviewViewModels.count, id: \.self) { index in
					ReviewRow(viewModel: self.listViewModel.reviewViewModels[index])
						.onAppear(perform: { self.listViewModel.fetchMoreReviewIfEndIndex(index) }
					)
				}
				.navigationBarTitle("Reviews")
				}
			}
		}
	}
}

struct ReviewList_Previews: PreviewProvider {
    static var previews: some View {
		ReviewList(listViewModel: ReviewListViewModel(client: DefaultApiClient(service: NetworkService(), endpoint: EndpointUrlHelper.default), tourId: 23776))
		//pass mocked api client
    }
}
