//
//  DragRelocateDelegate.swift
//  osbc
//
//  Created by Zubair Sheikh on 13/11/2021.
//

import Foundation
import SwiftUI

public struct DragRelocateDelegate<T: BaseCodable>: DropDelegate {
    public let item: T
    @Binding public var listData: [T]
    @Binding public var current: T?
    
    public init(item: T, listData: Binding<[T]>, current: Binding<T?>){
        self.item = item
        self._listData = listData
        self._current = current
    }
    
    public func dropEntered(info: DropInfo) {
        if item != current {
            guard let from = listData.firstIndex(of: current!) else {return}
            guard let to = listData.firstIndex(of: item) else {return}
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                              toOffset: to > from ? to + 1 : to)
            }
        }
    }
    
    public func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    public func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}
