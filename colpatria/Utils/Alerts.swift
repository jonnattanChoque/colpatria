//
//  Alerts.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

class Alerts {

    static var shared: Alerts = {
        let instance = Alerts()
        return instance
    }()
    
    private init() {}

    func simple(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.General.Alert.button, style: .default, handler: handler))
        
        return alert
    }
}
