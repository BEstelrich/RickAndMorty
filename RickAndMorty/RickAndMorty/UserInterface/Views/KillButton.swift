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
        killState()
        resucitateState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        killState()
        resucitateState()
    }
    
    func killState() {
        self.setTitle("KILL", for: .normal)
        self.backgroundColor = UIColor.red
    }
    
    func resucitateState() {
        self.setTitle("RESUSCITATE", for: .normal)
        self.backgroundColor = UIColor.lightGray
    }
}
