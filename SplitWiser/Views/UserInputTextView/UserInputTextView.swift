//
//  UserInputTextView.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 11/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class UserInputTextView: UIView {
    
    @IBOutlet weak var delegate : UserInputTextViewDelegate?

    @IBInspectable var labelPlaceHolderText : String?
    @IBInspectable var textFieldPlaceHolderText : String?
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var inputTextField : UITextField!
    
    override func awakeFromNib() {
        titleLabel.text = labelPlaceHolderText
        inputTextField.placeholder = textFieldPlaceHolderText

        inputTextField.addTarget(self, action: #selector(typingStarted), for: .editingChanged)
    }
    
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
        let ourNib = UINib(nibName: "UserInputTextView", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        self.addSubview(theView)
    }
}

extension UserInputTextView : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Did End Editing was called.")
    }
    
    @objc func typingStarted(textField : UITextField) {
        if textField.text?.isEmpty == false {
            delegate?.didBeginEnteringInTextField(enteredText: textField.text!)
        }
        
        if textField.text?.isEmpty == true {
            delegate?.didRemoveTextInTextField()
        }
    }
    
}
