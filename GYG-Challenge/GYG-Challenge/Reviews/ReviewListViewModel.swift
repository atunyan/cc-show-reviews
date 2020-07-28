//
//  ReviewListViewModel.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/24/20.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import Combine
import Foundation

enum SortType {
	case date
	case rating
}

enum SortParameter: String {
	case ratingAsc = "rating:asc"
	case ratingDesc = "rating:desc"
	case dateAsc = "date:asc"
	case dateDesc = "date:desc"
}

final class ReviewListViewModel: ObservableObject {

	@Published private(set) var reviewViewModels = [ReviewViewModel]()
	@Published var shouldShowActivityIndicator = true

	private let limit: Int
	private var isFetchingReviews: Bool
	private let apiClient: ApiClient
	private let tourId: Int
	private var sortQuery: SortParameter

	init(client: ApiClient, tourId: Int) {
		self.apiClient = client
		self.tourId = tourId
		self.limit = 10
		self.isFetchingReviews = false
		self.sortQuery = SortParameter.dateDesc

		self.fetchReviewsWithPagination(limit: limit, offset: 0, sortQuery: sortQuery.rawValue)
	}

	private func fetchReviewsWithPagination(limit: Int?, offset: Int?, sortQuery: String?) {
		isFetchingReviews = true
		apiClient.fetchReviews(with: tourId, limit: limit, offset: offset, sortQuery: sortQuery) { [weak self] result in
			switch result {
			case .success(let reviews):
				self?.reviewViewModels += reviews.reviews.map{ ReviewViewModel(model: $0) }
			case .failure(let error):
				print("Error: \(error)")
			}
			self?.shouldShowActivityIndicator = false
			self?.isFetchingReviews = false
		}
	}

	private func fetchSortedReviews(by parameter: SortParameter) {
		shouldShowActivityIndicator = true
		apiClient.fetchReviews(with: tourId, limit: limit, offset: 0, sortQuery: parameter.rawValue) { [weak self] result in
			switch result {
			case .success(let reviews):
				self?.reviewViewModels = reviews.reviews.map{ ReviewViewModel(model: $0) }
			case .failure(let error):
				print("Error: \(error)")
			}
			self?.shouldShowActivityIndicator = false
		}
	}

	func fetchMoreReviewIfEndIndex(_ index: Int) {
		if !isFetchingReviews && index == reviewViewModels.count - 1 {
			let newOffset = reviewViewModels.count
			fetchReviewsWithPagination(limit: limit, offset: newOffset, sortQuery: sortQuery.rawValue)
		}
	}

	func sortBy(parameter: SortParameter) {
		sortQuery = parameter
		fetchSortedReviews(by: parameter)
	}

	func sortByRating(desc: Bool) {
		sortBy(parameter: (desc ? SortParameter.ratingDesc : SortParameter.ratingAsc))
	}

	func sortByDate(desc: Bool) {
		sortBy(parameter: (desc ? SortParameter.dateDesc : SortParameter.dateAsc))
	}
}
