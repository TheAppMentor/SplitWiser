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
    
    @IBInspectable var allowsEditing : Bool = false

    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var participantListView: ParticipantListView!
    @IBOutlet weak var eventDescription: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupEditing()
    }
    
    func setupEditing(){
            profilePicButton.isUserInteractionEnabled = allowsEditing
            eventName.isUserInteractionEnabled = allowsEditing
            eventDescription.isUserInteractionEnabled = allowsEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupEditing()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        setupEditing()
    }
    
    override func awakeFromNib() {
        setupEditing()
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
