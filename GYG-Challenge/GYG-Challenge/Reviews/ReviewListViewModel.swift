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
	@Published var isLoading = false
	var pagination: Pagination?
	var apiClient: ApiClient
	var tourId: Int

	init(client: ApiClient, tourId: Int) {
		self.apiClient = client
		self.tourId = tourId
		self.fetchReviews(limit: 10, offset: nil)
	}

	private func fetchReviews(limit: Int?, offset: Int?) {
		apiClient.fetchReviews(with: tourId, limit: limit, offset: offset) { [weak self] (result, error) in
			if let error = error {
				print(error)
				return
			}

			guard let result = result else { return }
			self?.pagination = result.pagination
			self?.reviewViewModels += result.reviews.map{ ReviewViewModel(model: $0)}
		}
	}


	func isLastIndex(_ index: Int) {
		if index == reviewViewModels.count - 1 {
			let newOffset = (pagination?.offset ?? 0) + (pagination?.limit ?? 10)
			fetchReviews(limit: pagination?.limit, offset: newOffset)
		}
	}
}
