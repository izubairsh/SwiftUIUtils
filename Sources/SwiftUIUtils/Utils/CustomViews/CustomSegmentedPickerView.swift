//
//  CustomSegmentedPickerView.swift
//  osbc
//
//  Created by Zubair Sheikh on 13/11/2021.
//

import SwiftUI

public struct CustomSegmentedPickerView: View {
    @Binding public var selectedIndex: Int
    public var titles: [String]
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)
    
    public init(selectedIndex: Binding<Int>, titles: [String]){
        self._selectedIndex = selectedIndex
        self.titles = titles
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 10) {
                ForEach(self.titles.indices, id: \.self) { index in
                    Button(action: { self.selectedIndex = index }) {
                        Text(self.titles[index])
                            .foregroundColor(self.selectedIndex == index ? Color.white : Color.black)
                    }
                    .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)).background(
                        GeometryReader { geo in
                            Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                        }
                    )
                    
                }
            }
            .background(
                Capsule().fill(Color.black)
                    .frame(width: self.frames[self.selectedIndex].width,
                           height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                    .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
                , alignment: .leading
            )
        }
        .animation(.default)
        .background(Capsule().fill(Color.gray.opacity(0.2)))
        
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}
