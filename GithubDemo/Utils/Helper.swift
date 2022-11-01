//
//  Helper.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import  UIKit

let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let SCALE_FACTOR: CGFloat = IS_IPAD ? 1.6 : 1

class Helper{
    class func getAttributedText(text: String, color: UIColor, alignment: NSTextAlignment, font: UIFont) -> NSAttributedString{
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)

        let textAlignment = NSMutableParagraphStyle()
        textAlignment.alignment = alignment

        return NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: textAlignment])
    }

    class func getDateInReadableFormat(_ input: String) -> String?{
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.locale = Locale.autoupdatingCurrent
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputDateFormatter.date(from: input) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: date)
        }
        return nil
    }

    class func getMultiAttributedText(_ text1: String, _ text2: String) -> NSMutableAttributedString? {
        let attrs1 = [NSAttributedString.Key.font: UIFont.setupFont(12.0, true), NSAttributedString.Key.foregroundColor: UIColor.gray]

        let attrs2 = [NSAttributedString.Key.font: UIFont.setupFont(12.0, true), NSAttributedString.Key.foregroundColor: UIColor.black]

        let attributedString1 = NSMutableAttributedString(string: text1, attributes: attrs1)

        let attributedString2 = NSMutableAttributedString(string: text2, attributes: attrs2)

        attributedString1.append(attributedString2)
        return attributedString1
    }
}


extension Collection {
  subscript(safe index: Index) -> Iterator.Element? {
    guard indices.contains(index) else { return nil }
    return self[index]
  }
}

extension UIFont{
    class func setupFont(_ size: CGFloat, _ isBold: Bool = false) -> UIFont{
        let fontSize = size * SCALE_FACTOR
        return isBold ? UIFont.boldSystemFont(ofSize: fontSize):  UIFont.systemFont(ofSize: fontSize)
    }
}
