//
//  ReviewViewModel.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/24/20.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import SwiftUI

final class ReviewViewModel: ObservableObject {

	@Published var model: Review
	@ObservedObject private var imageLoader = ImageLoader()

	init(model: Review) {
		self.model = model
	}

	var id: Int {
		return model.id
	}

	var message: String {
		return model.message
	}

	var date: String {
		return isoDateFormatter(dateString: model.created)
	}

	var rating: Int {
		return model.rating
	}

	var title: String {
		return model.enjoyment
	}

	var userInfo: String {
		guard let countryName = model.author.country else {
			return model.author.fullName
		}
		return model.author.fullName + " - " + countryName
	}


	var userPhoto: Image {
		guard let urlString = model.author.photo, let imageUrl = URL(string: urlString) else {
			return Image(systemName: "person")
		}
		imageLoader.load(url: imageUrl)
		guard let uiImage = imageLoader.uiImage else {
			return Image(systemName: "person")
		}
		return Image(uiImage: uiImage)
	}

}
