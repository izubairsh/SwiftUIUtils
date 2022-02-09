//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 09/02/2022.
//

import Foundation
import FLAnimatedImage
import SwiftUI

public struct GifView: UIViewRepresentable{
    
    public let animatedView = FLAnimatedImageView()
    public var fileName: String
    
    public init(fileName:String){
        self.fileName = fileName
    }
    
    public func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIView {
        let view = UIView()
        
        let path: String = Bundle.main.path(forResource: fileName, ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        let gifData = try! Data(contentsOf: url)
        
        let gif = FLAnimatedImage(animatedGIFData: gifData)
        animatedView.animatedImage = gif
        
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animatedView)
        
        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GifView>) {
        
    }
}
