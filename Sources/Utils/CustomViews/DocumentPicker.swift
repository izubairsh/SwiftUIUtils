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
        
        public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            // Start accessing a security-scoped resource.
                guard url.startAccessingSecurityScopedResource() else {
                    // Handle the failure here.
                    return
                }

                // Make sure you release the security-scoped resource when you finish.
                defer { url.stopAccessingSecurityScopedResource() }

                // Use file coordination for reading and writing any of the URL’s content.
                var error: NSError? = nil
                NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { (url) in
                        
                    let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]
                        
                    // Get an enumerator for the directory's content.
                    guard let fileList =
                        FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
                        Swift.debugPrint("*** Unable to access the contents of \(url.path) ***\n")
                        return
                    }
                        
                    for case let file as URL in fileList {
                        // Start accessing the content's security-scoped URL.
                        guard url.startAccessingSecurityScopedResource() else {
                            // Handle the failure here.
                            continue
                        }

                        // Do something with the file here.
                        Swift.debugPrint("chosen file: \(file.lastPathComponent)")
                        base.url?.wrappedValue = file
                        // Make sure you release the security-scoped resource when you finish.
                        url.stopAccessingSecurityScopedResource()
                        base.presentationMode.wrappedValue.dismiss()
                    }
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
        url: Binding<URL?>,
        onCancel: (() -> Void)? = nil
    ) {
        self.url = url
        self.onCancel = onCancel
    }
    
}

#endif
