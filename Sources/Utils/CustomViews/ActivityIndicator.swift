//
//  ActivityIndicator.swift
//  osbc
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation
import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {

    @Binding public var isAnimating: Bool
    public let style: UIActivityIndicatorView.Style
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style){
        self._isAnimating = isAnimating
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = UIColor.gray
        return activityIndicatorView
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
