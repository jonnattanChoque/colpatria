//
//  StringExtension.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation

extension String {
    func formatDate() -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd"

        guard let oldDate = olDateFormatter.date(from: self) else { return "" }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"

        return convertDateFormatter.string(from: oldDate)
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
