//
//  DocumentPicker.swift
//  
//
//  Created by Zubair Sheikh on 07/02/2022.
//

import Foundation
import SwiftUI
import MobileCoreServices

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI

/// A SwiftUI port of `UIDocumentPickerViewController`.
public struct DocumentPicker: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIDocumentPickerViewController
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var url: Binding<URL?>?
    var onCancel: (() -> Void)?
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        let controller = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .open)
        controller.delegate = context.coordinator
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        context.coordinator.base = self
    }
    
    public class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        var base: DocumentPicker
        
        init(base: DocumentPicker) {
            self.base = base
        }
        
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            base.url?.wrappedValue = urls[0]
            base.presentationMode.wrappedValue.dismiss()
        }
        
        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            if let onCancel = base.onCancel {
                onCancel()
            } else {
                base.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        .init(base: self)
    }
}

// MARK: - API -

extension DocumentPicker {
    
    public init(
        url: Binding<URL?>,
        onCancel: (() -> Void)? = nil
    ) {
        self.url = url
        self.onCancel = onCancel
    }
    
}

#endif
