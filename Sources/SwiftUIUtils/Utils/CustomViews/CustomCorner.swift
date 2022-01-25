//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 24/01/2022.
//

import SwiftUI

public struct CustomCorner: Shape{
    
    public var corners: UIRectCorner
    public var radius: CGFloat
    public init(corners: UIRectCorner, radius: CGFloat){
        self.corners = corners
        self.radius = radius
    }
    public func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

public struct RoundedCorners: View {
    public var color: Color = .blue
    public var tl: CGFloat = 0.0
    public var tr: CGFloat = 0.0
    public var bl: CGFloat = 0.0
    public var br: CGFloat = 0.0
    
    public init(color: Color = .blue, tl: CGFloat = 0.0, tr: CGFloat = 0.0, bl: CGFloat = 0.0, br: CGFloat = 0.0){
        self.color = color
        self.tl = tl
        self.tr = tr
        self.bl = bl
        self.br = br
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}
