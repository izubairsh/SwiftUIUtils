//
//  NFCSessionWrite.swift
//  osbc
//
//  Created by Zubair Sheikh on 18/06/2021.
//

import Foundation
import CoreNFC

public class NFCSessionWrite : NSObject, NFCNDEFReaderSessionDelegate {
    public var session : NFCNDEFReaderSession?
    public var message = ""
    public var recordType : RecordType = .text
    
    public func beginScanning(message : String, recordType : RecordType) {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("Scanning Not Supported on This Device.")
            return
        }
        self.message = message
        self.recordType = recordType
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = AppStrings.holdToActivate.localized1()
        session?.begin()
    }
    
    public func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        // Do nothing here unless want to add extra action
        // This function is to silence the warning in the console
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Nothing here but you can implement your own error
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Nothing here since we won't be using it.
        
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        // The logic for write will be here
        if tags.count > 1 {
            // Restart polling in 2000 milliseconds.
            let retryInterval = DispatchTimeInterval.milliseconds(2000)
            session.alertMessage = "More than 1 tag is detected. Please remove all tags and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        let tag = tags.first!
        print("Get first tag")
        session.connect(to: tag, completionHandler: { (error: Error?) in
            if nil != error {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                print("Error connect to tag")
                return
            }
            
            tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "Unable to query the NDEF status of tag."
                    session.invalidate()
                    print("unable to query ndef status of bag")
                    return
                }
                
                switch ndefStatus {
                case .notSupported:
                    print("Not Support")
                    session.alertMessage = "Tag is not NDEF compliant."
                    session.invalidate()
                case .readOnly:
                    print("Read Only")
                    session.alertMessage = "Tag is read only."
                    session.invalidate()
                case .readWrite:
                    print("Writing Available")
                    
                    let payLoad : NFCNDEFPayload?
                    switch self.recordType {
                    case .text:
                        guard !self.message.isEmpty else {
                            session.alertMessage = "Empty Data"
                            session.invalidate(errorMessage: "Empty Text Data")
                            return
                        }
                        
                        payLoad = NFCNDEFPayload(format: .nfcWellKnown, type: "T".data(using: .utf8)! , identifier: "Text".data(using: .utf8)!,payload: "\u{02}en\(self.message)".data(using: .utf8)!)
                        
                    case .url:
                        // Validate read date
                        guard let url = URL(string: self.message) else {
                            session.alertMessage = "Unrecognize Data"
                            session.invalidate(errorMessage: "Read data is not a URL")
                            return
                        }
                        payLoad = NFCNDEFPayload.wellKnownTypeURIPayload(url: url)
                    }
                    
                    let NFCMessage = NFCNDEFMessage(records: [payLoad!])
                    tag.writeNDEF(NFCMessage, completionHandler: { (error: Error?) in
                        if nil != error {
                            session.alertMessage = "Write NDEF message fail: \(error!)"
                            print("fails: \(error!.localizedDescription)")
                        } else {
                            session.alertMessage = "Write NDEF message successful."
                            print("successs")
                        }
                        session.invalidate()
                    })
                @unknown default:
                    print("Unknow Error")
                    session.alertMessage = "Unknown NDEF tag status."
                    session.invalidate()
                }
            })
        })
    }
}
