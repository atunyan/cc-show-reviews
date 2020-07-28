//
//  ApiClientMock.swift
//  GYG-Challenge
//

import Foundation

final class ApiClientMock: ApiClient {
	let reviews = Reviews(reviews: [Review.defualt, Review.defualt, Review.defualt],
						  totalCount: 10,
						  pagination: Pagination(limit: 1, offset: 0))

	func fetchReviews(with tourId: Int, limit: Int?, offset: Int?, sortQuery: String?, _ onComplete: @escaping (Result<Reviews, NetworkError>) -> Void) {
		onComplete(.success(reviews))
	}
}
