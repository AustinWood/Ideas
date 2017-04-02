//
//  CircleView.swift
//  Otym
//
//  Created by Austin Wood on 2016-12-14.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override func awakeFromNib() {
        self.backgroundColor = CustomColor.dark1
        self.layer.cornerRadius = self.frame.height / 2
        layer.borderWidth = 0.5
        layer.borderColor = CustomColor.gray.cgColor
    }
    
}
