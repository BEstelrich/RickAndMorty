//
//  Extensions.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

extension UIImageView {

    /// Fetch image asynchronously from API.
    /// - Parameter string: that's the link from the API.
    public func fetchImageFromString(_ string: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: string)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
    
}
