//
//  DocumentPicker.swift
//  
//
//  Created by Zubair Sheikh on 07/02/2022.
//

import Foundation
import SwiftUI


#if os(iOS) || targetEnvironment(macCatalyst)
import MobileCoreServices

/// A SwiftUI port of `UIDocumentPickerViewController`.
public struct DocumentPicker: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIDocumentPickerViewController
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var value: Binding<String>?
    var data: Binding<Data?>?
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
            let url = urls.first!
            guard url.startAccessingSecurityScopedResource() else {
                print("can't access")
                return
            }
            defer { url.stopAccessingSecurityScopedResource() }
            do {
                base.data?.wrappedValue = try Data(contentsOf: url)
                base.value?.wrappedValue = url.lastPathComponent
            } catch {
                print(error)
            }
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
        value: Binding<String>,
        data: Binding<Data?>,
        onCancel: (() -> Void)? = nil
    ) {
        self.value = value
        self.data = data
        self.onCancel = onCancel
    }
    
}

#endif
