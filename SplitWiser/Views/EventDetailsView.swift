//
//  AddEventView.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/23/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

@IBDesignable

class EventDetailsView: UIView {
    
    weak var delegate : EventDetailsDelegate? = nil
    
    @IBInspectable var allowsEditing : Bool = false
    
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var participantListView: ParticipantListView!
    @IBOutlet weak var eventDescription: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupEditing()
        
        eventName.delegate = self
        eventDescription.delegate = self
    }
    
    func setupEditing(){
        profilePicButton.isUserInteractionEnabled = allowsEditing
        eventName.isUserInteractionEnabled = allowsEditing
        eventDescription.isUserInteractionEnabled = allowsEditing
        
        eventName.addTarget(self, action: #selector(typingEventName), for: .editingChanged)
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
        let ourNib = UINib(nibName: "EventDetailsView", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        theView.frame = bounds
        theView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        self.addSubview(theView)
    }
    
    @objc func typingEventName (textField : UITextField){
        if textField.text?.isEmpty == false {
            delegate?.didBeginEnteringEventName(eventName: textField.text!)
        }

        if textField.text?.isEmpty == true {
            delegate?.didRemoveEventName(eventName: "")
        }

    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension EventDetailsView : UITextFieldDelegate{
    
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField.tag == 1111{ // Event name text field
//            if textField.text?.isEmpty == false {
//                delegate?.didBeginEnteringEventName(eventName: textField.text!)
//            }
//        }
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if (textField.text?.isEmpty)!{
//            delegate?.didRemoveEventName(eventName: "")
//        }
//
//        return true
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.tag == 1111{ // Event name text field
            if let validText = textField.text{
                delegate?.didEnterEventName(eventName: validText)
            }
		} else if textField.tag == 1112{ // Event description text field
			if let validText = textField.text{
				delegate?.didEnterEventDescription(eventDescription: validText)
			}
		}
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1111{ // Event name text field
            guard textField.text?.isEmpty == false else { return false }
        }
        return true
    }
    
}




protocol EventDetailsDelegate : AnyObject {
    func didBeginEnteringEventName(eventName : String)
    func didRemoveEventName(eventName : String)
    func didEnterEventName(eventName : String)
    func didEnterEventDescription(eventDescription : String)
    func didAddEventProfilePic(profilePic : UIImage)
    func didAddUserToEvent(userID : UUID)
}

extension EventDetailsDelegate {
    func didEnterEventName(eventName : String) {
        // Empty Implementation.
    }
    
    func didEnterEventDescription(eventDescription : String){
        
    }
    
    func didAddEventProfilePic(profilePic : UIImage){
        
    }
    
    func didAddUserToEvent(userID : UUID){
        
    }
}

