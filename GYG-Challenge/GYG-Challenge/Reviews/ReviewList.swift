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
		NavigationView {
			List(0..<viewModel.reviewViewModels.count, id: \.self) { index in
				ReviewRow(viewModel: self.viewModel.reviewViewModels[index])
					.onAppear(perform: { self.viewModel.isLastIndex(index) }
				)
			}
			.navigationBarTitle("Reviews")
		}
    }
}

struct ReviewList_Previews: PreviewProvider {
    static var previews: some View {
		ReviewList(viewModel: ReviewListViewModel(client: DefaultApiClient(service: NetworkService(), endpoint: EndpointUrlHelper.default), tourId: 23776))
		//pass mocked api client
    }
}
