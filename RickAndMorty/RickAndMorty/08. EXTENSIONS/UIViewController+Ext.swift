//
//  UIViewController+Ext.swift
//  RickAndMorty
//
//  Created by BES on 2020-02-20.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(_ alert: Alert) {
        DispatchQueue.main.async {
            let alertController = AlertManager()
            let alert = alertController.presentAlert(alert)

            self.present(alert, animated: true)
        }
    }
    
}
