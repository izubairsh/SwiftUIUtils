//
//  CustomButton.swift
//  osbc
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import SwiftUI

public struct CustomButton: ButtonStyle {
    
    public var backgroundColor: Color = Color.primaryColor
    public var foregroundColor: Color = Color.white
    public var isFullWidth: Bool = true
    public var isValid: Bool = true
    
    public init(backgroundColor: Color = Color.primaryColor, foregroundColor: Color = Color.white, isFullWidth: Bool = true, isValid: Bool = true){
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.isFullWidth = isFullWidth
        self.isValid = isValid
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .applyModifier(if: isFullWidth, FullWidthModifier())
            .lineLimit(1)
            .foregroundColor(foregroundColor)
            .padding()
            .background(isValid ? backgroundColor : .gray)
            .cornerRadius(8)
            .shadow(radius: 5)
            
    }
}
