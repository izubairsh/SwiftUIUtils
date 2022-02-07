//
//  DocumentPicker.swift
//  
//
//  Created by Zubair Sheikh on 07/02/2022.
//

import Foundation
import SwiftUI
import MobileCoreServices

public struct DocumentPicker: UIViewControllerRepresentable {
    
    public var documentTypes: [String]
    public var callback: (URL) -> ()
    
    public init(documentTypes: [String], callback: @escaping (URL) -> ()) {
        self.callback = callback
        self.documentTypes = documentTypes
    }

    public func makeCoordinator() -> Coordinator { Coordinator(self) }

    public func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        controller.allowsMultipleSelection = false
        controller.delegate = context.coordinator
        return controller
    }

    public class Coordinator: NSObject, UIDocumentPickerDelegate {
        public var parent: DocumentPicker
        public init(_ pickerController: DocumentPicker) {
            self.parent = pickerController
        }
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.callback(urls[0])
        }
        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        }
    }
}

