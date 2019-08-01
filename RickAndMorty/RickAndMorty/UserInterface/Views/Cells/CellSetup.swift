//
//  CellSetup.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class CellSetup {

    /// This function defines cell size related to the number of columns we want to display in the screen.
    ///
    /// - Parameters:
    ///   - customWidth: the cell width expected for the cell.
    ///   - customHeight: the cell height expected for the cell.
    ///   - customPadding: the minimum padding between cells.
    /// - Returns: returns a CGSize that can passed throught collection view controller protocol functions to generate the actual cell size.
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
