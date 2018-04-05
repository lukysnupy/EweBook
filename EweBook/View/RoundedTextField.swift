//
//  RoundedTextField.swift
//  EweBook
//
//  Created by Lukáš Růžička on 05.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2.0
    }

}
