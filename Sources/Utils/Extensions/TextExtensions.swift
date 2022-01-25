//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 25/01/2022.
//


import Foundation
import SwiftUI

extension Text {
    public func circleTextModifier(width: CGFloat = 200, height: CGFloat = 200) -> some View {
        self
            .font(.title)
            .frame(width: width, height: height)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(.white)
            .background(Color.black)
            .clipShape(Circle())
            .shadow(radius: 10)
   }
}
