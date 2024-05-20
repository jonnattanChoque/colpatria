//
//  DoubleExtension.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
