//
//  RoundedView.swift
//  EweBook
//
//  Created by Lukáš Růžička on 05.04.18.
//  Copyright © 2018 Lukáš Růžička. All rights reserved.
//

import UIKit

class ShadowBarView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
    }

}
