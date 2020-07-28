//
//  CircleImage.swift
//  GYG-Challenge
//


import SwiftUI

struct CircleImage: View {

	@State var image: Image

    var body: some View {
		image
			.frame(width: 50, height: 50)
			.aspectRatio(contentMode: .fit)
			.clipShape(Circle())
			.overlay(
                Circle().stroke(Color.white, lineWidth: 1))
            .shadow(radius: 3)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
		CircleImage(image: Image(systemName: "person"))
    }
}
