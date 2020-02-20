//
//  AlertManager.swift
//  RickAndMorty
//
//  Created by BES on 2019-08-01.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

struct Alert {
    
    var title: String
    var message: String
    var buttonTitle: String

}


class AlertManager: UIAlertController {
    
    func presentAlert(_ alert: Alert) -> UIAlertController {
        let alertController = UIAlertController(title: alert.title,
                                      message: alert.message,
                                      preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: alert.buttonTitle,
                                   style: .default,
                                   handler: nil)
        
        alertController.addAction(alertAction)
        
        return alertController
    }
    
}


