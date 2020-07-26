//
//  ReviewViewModel.swift
//  GYG-Challenge
//
//  Created by toxicsun on 7/24/20.
//  Copyright © 2020 Anonymous. All rights reserved.
//

import SwiftUI

struct ReviewViewModel: Identifiable {

	var model: Review

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

	/*var profileImage: Image {
		return Image(
	}*/

	var userInfo: String {
		guard let countryName = model.author.country else {
			return model.author.fullName
		}
		return model.author.fullName + " - " + countryName
	}

}
