//
//  AddEventView.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

@IBDesignable

class AddEventView: UIView {

    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var participantListView: ParticipantListView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        let bundle = Bundle.init(for: type(of: self))
        let ourNib = UINib(nibName: "AddEventView", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        theView.frame = bounds
        theView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        self.addSubview(theView)
    }

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
