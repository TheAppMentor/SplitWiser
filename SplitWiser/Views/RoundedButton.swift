//
//  RoundedButton.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 10/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        backgroundColor = UIColor(red: 0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }

}
