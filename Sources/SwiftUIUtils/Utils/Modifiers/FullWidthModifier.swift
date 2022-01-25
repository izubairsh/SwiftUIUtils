//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 17/01/2022.
//

import Foundation
import SwiftUI

public struct FullWidthModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
    }
}
