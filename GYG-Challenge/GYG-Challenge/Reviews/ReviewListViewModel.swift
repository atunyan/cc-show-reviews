//
//  ReviewListViewModel.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/24/20.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import Combine
import Foundation

final class ReviewListViewModel: ObservableObject {

	@Published var reviewViewModels = [ReviewViewModel]()

	init(client: ApiClient, tourId: Int) {
		self.fetchReviews(from: client, for: tourId)
	}

	private func fetchReviews(from client: ApiClient, for tourId: Int) {
		client.fetchReviews(with: tourId) { [weak self] (result, error) in
			if let error = error {
				//keep error state
				return
			}

			guard let result = result else { return }
			self?.reviewViewModels = result.reviews.map{ ReviewViewModel(model: $0)}

		}
	}
}
