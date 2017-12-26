//
//  RoundedImageView.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable

class RoundedImageView: UIImageView {
    
    @IBInspectable var isRounded : Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if isRounded{
            layer.cornerRadius = frame.width/2
        }
    }
    
    override func awakeFromNib() {
        if isRounded{
            layer.cornerRadius = frame.width/2
            print("Awake From Nib : Setting the corner Radius  --> \(frame.width/2)")
        }
    }
    
    override func didMoveToSuperview() {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
}
