//
//  ImageExtensions.swift
//  Domiklik
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

extension Image {
    public func circleImageModifier(width: CGFloat = 200, height: CGFloat = 200, padding: CGFloat = 0, backgroundColor: Color = Color.white, foregroundColor: Color = .black) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
            .scaledToFit()
            .padding(padding)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}

extension WebImage {
    public func circleImageModifier(width: CGFloat = 200, height: CGFloat = 200, padding: CGFloat = 0) -> some View {
        self
            .resizable()
            .placeholder(Image(systemName: "person"))
            .frame(width: width, height: height)
            .scaledToFit()
            .padding(padding)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}

