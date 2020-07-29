//
//  ContentView.swift
//  GYG-Challenge
//

import SwiftUI
import Combine

enum SortType {
	case date
	case rating
}

struct ReviewList: View {

	@ObservedObject var viewModel: ReviewListViewModel
	@State private var sortByRatingDesc = false
	@State private var sortByDateDesc = true
	@State private var sortType = SortType.date

	var filterButtons: some View {
		VStack {
			HStack {
				Button(action: {
					self.sortByRatingDesc = !self.sortByRatingDesc
					self.viewModel.sortByRating(desc: self.sortByRatingDesc)
					self.sortType = SortType.rating
				}) {
					Text("Rating")
					Image(systemName: (sortByRatingDesc ? "arrow.up" : "arrow.down"))
				}
				.foregroundColor(sortType == SortType.rating ? Color.orange : Color.gray)
				.padding(10)

				Button(action: {
					self.sortByDateDesc = !self.sortByDateDesc
					self.viewModel.sortByDate(desc: self.sortByDateDesc)
					self.sortType = SortType.date
				}) {
					Text("Date")
					Image(systemName: (sortByDateDesc ? "arrow.up" : "arrow.down"))
				}
				.foregroundColor(sortType == SortType.date ? Color.orange : Color.gray)
				.padding(10)
			}
		}
	}

	var body: some View {
		VStack {
			if viewModel.shouldShowActivityIndicator {
				ActivityIndicator(shouldAnimate: $viewModel.shouldShowActivityIndicator)
			} else {
				NavigationView {
					List(0..<viewModel.reviewViewModels.count, id: \.self) { index in
						ReviewRow(viewModel: self.viewModel.reviewViewModels[index]
						)
						.onAppear(perform: { self.viewModel.fetchMoreReviewIfEndIndex(index)
						})
					}

				.navigationBarTitle("Reviews")
				.navigationBarItems(trailing: filterButtons)
				}
			}
		}
	}
}

struct ReviewList_Previews: PreviewProvider {
	static var previews: some View {
		ReviewList(viewModel: ReviewListViewModel(client: ApiClientMock(), tourId: 0))
	}
}
