//
//  ColorExtensions.swift
//  Domiklik
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation
import SwiftUI

extension Color {
    public static var primaryColor: Color {
        return Color(UIColor(named: "PrimaryColor")!)
    }
    public static var secondaryColor: Color {
        return Color(UIColor(named: "SecondaryColor")!)
    }
    public static var backgroundColor: Color {
        return Color(UIColor(named: "BackgroundColor")!)
    }
    public static var textColor: Color {
        return Color(UIColor(named: "TextColor")!)
    }
}
