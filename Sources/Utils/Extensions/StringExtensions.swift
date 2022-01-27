//
//  StringExtensions.swift
//  Domiklik
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation
import CoreImage.CIFilterBuiltins
import SwiftUI

extension String {

    public func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }

    public func isValid(field: FieldType) -> Bool {
        let pred = NSPredicate(format:"SELF MATCHES %@", field.getRegix())
        return pred.evaluate(with: self)
    }
    
    public func toURL(isUrl: Bool? = false) -> URL? {
        var urlString = self
        if ((isUrl ?? false) && !self.hasPrefix("http") ) {
            urlString = "https://www." + self
        }
        return URL(string: urlString)
    }

    public func localized1() -> String {
        let path = Bundle.main.path(forResource: UserDefaults.language, ofType: "lproj")
        guard let path = path else {
            print("invalid")
            return self
        }
        guard let bundle = Bundle(path: path) else {
            print("invalid")
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    
    public func generateQRCode() -> UIImage? {
        let data = Data(self.utf8)
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return nil
    }
    
}
