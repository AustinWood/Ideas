//
//  CustomNavController.swift
//  Otym
//
//  Created by Austin Wood on 2016-12-02.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.white
    }
    
}
