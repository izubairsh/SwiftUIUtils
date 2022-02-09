//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 25/01/2022.
//


import Foundation
import SwiftUI

extension Text {
    public func circleTextModifier(width: CGFloat = 200, height: CGFloat = 200, padding: CGFloat = 0, backgroundColor: Color = Color.white, foregroundColor: Color = .black) -> some View {
        self
            .frame(width: width, height: height)
            .padding(padding)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}
