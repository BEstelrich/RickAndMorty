//
//  CellSetup.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class CellSetup {

    func setCell(width customWidth: CGFloat, height customHeight: CGFloat, padding customPadding: CGFloat) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone  {
            return (UIApplication.shared.statusBarOrientation.isPortrait == true) ? CGSize(width: customWidth - customPadding, height: customHeight) : CGSize(width: (customWidth - customPadding)/2, height: customHeight)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return (UIApplication.shared.statusBarOrientation.isPortrait == true) ? CGSize(width: (customWidth - customPadding)/2, height: customHeight) : CGSize(width: (customWidth - customPadding)/3, height: customHeight)
        } else {
            return CGSize(width: customWidth - customPadding, height: customHeight)
        }
    }
    
}
