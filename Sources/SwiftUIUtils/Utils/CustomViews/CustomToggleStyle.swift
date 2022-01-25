//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 24/01/2022.
//

import Foundation
import SwiftUI

public struct CustomToggleStyle: ToggleStyle {
    public init(){}
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundColor(.black)
            Rectangle()
                .foregroundColor(configuration.isOn ? .black : .gray)
                .frame(width: 45, height: 25, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                    
                ).cornerRadius(12)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

public struct CheckToggleStyle: ToggleStyle {
    public init(){}
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
