//
//  ImageExtensions.swift
//  Domiklik
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import SwiftUI

extension Image {
    public func circleImageModifier(width: CGFloat = 200, height: CGFloat = 200, padding: CGFloat = 0, backgroundColor: Color = Color.white, foregroundColor: Color = .black) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .padding(padding)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}

#if os(iOS)
import SDWebImageSwiftUI
extension WebImage {
    public func circleImageModifier(width: CGFloat = 200, height: CGFloat = 200, padding: CGFloat = 0, backgroundColor: Color = Color.white, foregroundColor: Color = .black, placeholder: Image) -> some View {
        self
            .resizable()
            .placeholder(placeholder)
            .scaledToFit()
            .frame(width: width, height: height)
            .padding(padding)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}

#endif
