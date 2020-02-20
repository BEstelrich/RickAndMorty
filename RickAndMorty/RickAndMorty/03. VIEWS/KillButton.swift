//
//  KillButton.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class KillButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /// Presents the button with a kill layout.
    func killState() {
        self.setTitle("KILL", for: .normal)
        self.backgroundColor = UIColor.red
    }
    
    
    /// Presents the button with a resuscitate layout.
    func resuscitateState() {
        self.setTitle("RESUSCITATE", for: .normal)
        self.backgroundColor = UIColor.lightGray
    }
    
}
