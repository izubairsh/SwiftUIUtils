//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 17/01/2022.
//

import Foundation

public struct PickerPayload : Identifiable{
    public var id = UUID()
    public var type : RecordType
    public var pickerMessage : String
    
    public init(type: RecordType, pickerMessage: String){
        self.type = type
        self.pickerMessage = pickerMessage
    }
}
