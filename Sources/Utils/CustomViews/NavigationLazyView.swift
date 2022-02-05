//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 05/02/2022.
//

import Foundation
import SwiftUI

public struct NavigationLazyView<Content: View>: View {
    public let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
