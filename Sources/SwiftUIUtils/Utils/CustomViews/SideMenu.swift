//
//  SideMenu.swift
//  Wiz
//
//  Created by Zubair Sheikh on 17/06/2021.
//

import Foundation
import SwiftUI

struct SideMenu<MenuContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    private let menuContent: () -> MenuContent
    
    public init(isShowing: Binding<Bool>,
                @ViewBuilder menuContent: @escaping () -> MenuContent) {
        _isShowing = isShowing
        self.menuContent = menuContent
    }
    
    public func body(content: Content) -> some View {
        let drag = DragGesture().onEnded { event in
            if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
                withAnimation {
                    self.isShowing = event.translation.width > 0
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                content
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.isShowing ? geometry.size.width / 2 : 0)
                
                menuContent()
                    .frame(width: geometry.size.width / 2)
                    .transition(.move(edge: .leading))
                    .offset(x: self.isShowing ? 0 : -geometry.size.width / 2)
                
            }.gesture(drag)
            
        }
    }
}
