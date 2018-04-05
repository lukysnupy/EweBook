//
//  RoundedBtn.swift
//  EweBook
//
//  Created by Lukáš Růžička on 05.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit

class RoundedBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 2.0
        
        imageView?.contentMode = .scaleAspectFit
    }

}
