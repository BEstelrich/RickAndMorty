//
//  AlertManager.swift
//  RickAndMorty
//
//  Created by BES on 2019-08-01.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class AlertManager: UIAlertController {
    
    func showEpisodesErrorAlert() {
        let alert = UIAlertController(title: "No episodes error",
                                      message: "There is no episodes to show. Please try again.",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        UIApplication.shared.delegate?.window??.rootViewController!.present(alert, animated: true)
    }
    
    func showCharactersErrorAlert() {
        let alert = UIAlertController(title: "No characters error",
                                      message: "There is no characters to show. Please try again.",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        UIApplication.shared.delegate?.window??.rootViewController!.present(alert, animated: true)
    }
}
