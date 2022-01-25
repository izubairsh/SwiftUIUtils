//
//  File.swift
//  
//
//  Created by Zubair Sheikh on 17/01/2022.
//

import Foundation
import CoreNFC
import SwiftUI

public struct NFCButton : UIViewRepresentable {
    @Binding public var data : String // 2
    
    public init(data: Binding<String>){
        self._data = data
    }
    
    public func makeUIView(context: UIViewRepresentableContext<NFCButton>) -> UIButton {
        let button = UIButton()
        button.setTitle(AppStrings.readTap.localized(), for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = UIColor.black
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)

        return button // 5
    } // 3

    public func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<NFCButton>) {
        // Do nothing
    } // 4

    public func makeCoordinator() -> NFCButton.Coordinator { // 1
        return Coordinator(data: $data)
    }

    public class Coordinator : NSObject, NFCNDEFReaderSessionDelegate { // 2
        public var session : NFCNDEFReaderSession? // 1
        @Binding public var data : String // 5

        public init(data: Binding<String>) { // 6
            _data = data
        }

        public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { // 3
            // Check the invalidation reason from the returned error.
            if let readerError = error as? NFCReaderError {
                // Show an alert when the invalidation reason is not because of a
                // successful read during a single-tag read session, or because the
                // user canceled a multiple-tag read session from the UI or
                // programmatically using the invalidate method call.
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("Error nfc read: \(readerError.localizedDescription)")
                }
            }
          
            // To read new tags, a new session instance is required.
            self.session = nil
        }

        public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) { // 4
            guard
                let nfcMess = messages.first,
                let record = nfcMess.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = String(data: record.payload, encoding: .utf8)
            else {
                return
            }

            let array = payload.components(separatedBy: "/")
            self.data = array.last ?? ""
        }
        @objc public func beginScan(_ sender: Any) {
            guard NFCNDEFReaderSession.readingAvailable else {
                print("error: Scanning not support")
                return
            }

            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = AppStrings.holdToScan.localized()
            session?.begin()
        }

    }
}
