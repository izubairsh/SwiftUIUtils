import Foundation
import CoreNFC

public typealias NFCReadingCompletion = (Result<NFCNDEFMessage?, Error>) -> Void
public typealias TagReadingCompletion = (Result<String, Error>) -> Void

public enum NFCError: LocalizedError {
    case unavailable
    case invalidated(message: String)
    case invalidPayloadSize
    
    public var errorDescription: String? {
        switch self {
        case .unavailable:
            return "NFC Reader Not Available"
        case let .invalidated(message):
            return message
        case .invalidPayloadSize:
            return "NDEF payload size exceeds the tag limit"
        }
    }
}

public class NFCUtility: NSObject {
    public enum NFCAction {
        case readTag
        case writeTag(url: URL)
        
        var alertMessage: String {
            switch self {
            case .readTag:
                return "Place tag near iPhone to read"
            case .writeTag(_):
                return "Place tag near iPhone to activate"
            }
        }
    }
    
    private static let shared = NFCUtility()
    private var action: NFCAction = .readTag
    
    // 1
    private var session: NFCNDEFReaderSession?
    private var completion: TagReadingCompletion?
    
    // 2
    public static func performAction(
        _ action: NFCAction,
        completion: TagReadingCompletion? = nil
    ) {
        // 3
        guard NFCNDEFReaderSession.readingAvailable else {
            completion?(.failure(NFCError.unavailable))
            print("NFC is not available on this device")
            return
        }
        
        shared.action = action
        shared.completion = completion
        // 4
        shared.session = NFCNDEFReaderSession(
            delegate: shared.self,
            queue: nil,
            invalidateAfterFirstRead: false)
        // 5
        shared.session?.alertMessage = action.alertMessage
        // 6
        shared.session?.begin()
    }
}

// MARK: - NFC NDEF Reader Session Delegate
extension NFCUtility: NFCNDEFReaderSessionDelegate {
    public func readerSession(
        _ session: NFCNDEFReaderSession,
        didDetectNDEFs messages: [NFCNDEFMessage]
    ) {
        // Not used
    }
    
    private func handleError(_ error: Error) {
        session?.alertMessage = error.localizedDescription
        session?.invalidate()
    }
    
    public func readerSession(
        _ session: NFCNDEFReaderSession,
        didInvalidateWithError error: Error
    ) {
        if
            let error = error as? NFCReaderError,
            error.code != .readerSessionInvalidationErrorFirstNDEFTagRead &&
                error.code != .readerSessionInvalidationErrorUserCanceled {
            completion?(.failure(NFCError.invalidated(message: error.localizedDescription)))
        }
        
        self.session = nil
        completion = nil
    }
    
    public func readerSession(
        _ session: NFCNDEFReaderSession,
        didDetect tags: [NFCNDEFTag]
    ) {
        guard
            let tag = tags.first,
            tags.count == 1
        else {
            session.alertMessage = "There are too many tags present. Remove all and then try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
                session.restartPolling()
            }
            return
        }
        
        // 1
        session.connect(to: tag) { error in
            if let error = error {
                self.handleError(error)
                return
            }
            
            // 2
            tag.queryNDEFStatus { status, _, error in
                if let error = error {
                    self.handleError(error)
                    return
                }
                
                // 3
                switch (status, self.action) {
                case (.notSupported, _):
                    session.alertMessage = "Unsupported tag."
                    session.invalidate()
                case (.readOnly, _):
                    session.alertMessage = "Unable to write to tag."
                    session.invalidate()
                case (.readWrite, .writeTag(let url)):
                    self.write(url, tag: tag)
                case (.readWrite, .readTag):
                    self.read(tag: tag)
                default:
                    return
                }
            }
        }
    }
}

// MARK: - Utilities
extension NFCUtility {
    private func read(
        tag: NFCNDEFTag,
        alertMessage: String = "Tag Read",
        readCompletion: NFCReadingCompletion? = nil
    ) {
        tag.readNDEF { message, error in
            if let error = error {
                self.handleError(error)
                return
            }
            
            // 1
            if let readCompletion = readCompletion,
               let message = message {
                readCompletion(.success(message))
            } else if let message = message,
                      let record = message.records.first, let payload = String(data: record.payload, encoding: .utf8) {
                
                let array = payload.components(separatedBy: "/")
                self.completion?(.success(array.last ?? ""))
                self.session?.alertMessage = alertMessage
                self.session?.invalidate()
            } else {
                self.session?.alertMessage = "Could not decode tag data."
                self.session?.invalidate()
            }
        }
    }
    
    private func write(
        _ url: URL,
        tag: NFCNDEFTag
    ) {
        guard let payload = NFCNDEFPayload.wellKnownTypeURIPayload(url: url) else {
            self.handleError(NFCError.invalidated(message: "Bad data"))
            return
            
        }
        let message = NFCNDEFMessage(records: [payload])
        tag.queryNDEFStatus { _, capacity, _ in
            guard message.length <= capacity else {
                self.handleError(NFCError.invalidPayloadSize)
                return
            }
            tag.writeNDEF(message) { error in
                if let error = error {
                    self.handleError(error)
                    return
                }
                if self.completion != nil {
                    self.read(tag: tag, alertMessage: "Card activated successfully")
                }
            }
        }
    }
}
