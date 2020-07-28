//
//  ApiClientMock.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/27/20.
//  Copyright © 2020 Anonymous. All rights reserved.
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
