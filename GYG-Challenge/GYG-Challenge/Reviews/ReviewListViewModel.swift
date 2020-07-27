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

	@Published private(set) var reviewViewModels = [ReviewViewModel]()
	@Published var shouldShowActivityIndicator = true

	private(set) var pagination = Pagination(limit: 0, offset: 0)
	private(set) var isFetchingReviews = false
	private(set) var apiClient: ApiClient
	private(set) var tourId: Int

	init(client: ApiClient, tourId: Int) {
		self.apiClient = client
		self.tourId = tourId
		self.fetchReviews()
	}

	private func fetchReviews(limit: Int = 10, offset: Int = 0) {
		isFetchingReviews = true
		shouldShowActivityIndicator = true
		apiClient.fetchReviews(with: tourId, limit: limit, offset: offset) { [weak self] result in
			switch result {
			case .success(let reviews):
				self?.pagination = reviews.pagination
				self?.reviewViewModels += reviews.reviews.map{ ReviewViewModel(model: $0) }
			case .failure(let error):
				print("Error: \(error)")
			}
			self?.shouldShowActivityIndicator = false
			self?.isFetchingReviews = false
		}
	}

	func fetchMoreReviewIfEndIndex(_ index: Int) {
		if !isFetchingReviews && index == reviewViewModels.count - 1 {
			print("Offset: \(pagination.offset)")
			let newOffset = pagination.offset + pagination.limit
			fetchReviews(limit: pagination.limit, offset: newOffset)
		}
	}
}
