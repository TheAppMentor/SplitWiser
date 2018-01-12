//
//  PhoneNumberInputView.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 05/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import CountryKit

protocol PhoneNumberInputViewDelegate {
    func userEnteredPhoneNumber(thePhoneNumber : String)
}

class PhoneNumberInputView: UIView {
    
    var delegate : PhoneNumberInputViewDelegate?
    
    let countryKit = CountryKit()
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    var countryCodeString : String? {
        guard let validCode = countryCode.text else {
            return nil
        }
        
        if let theCountry = fetchCountryForCode(code: validCode){
            if let validPhoneCode = theCountry.phoneCode{
                return String(describing: validPhoneCode)
            }
        }
        
        return nil
    }
    
    func fetchCountryForCode(code : String) -> Country?{
        let theCountry = countryKit.countries.filter({$0.phoneCode == Int(code)})
        return theCountry.first ?? nil
    }

    var phoneNumberString : String? {
        guard let validPhone = phoneNumber.text else {
            return nil
        }
        
        return validPhone
    }

    @IBAction func processEnteredPhoneNumber(_ sender: UIButton) {
        
        guard let theCountryCode = countryCodeString else {
            return
        }

        guard let thePhoneNum = phoneNumberString else {
            return
        }

        let theNumber = "+" + theCountryCode + thePhoneNum
        
        // Check if phone number is valid.
        delegate?.userEnteredPhoneNumber(thePhoneNumber: theNumber)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
    }
    
    func setupView() {
        let bundle = Bundle.init(for: type(of: self))
        let ourNib = UINib(nibName: "PhoneNumberInputView", bundle: bundle)
        let theView = ourNib.instantiate(withOwner: self, options: nil).first as! UIView
        theView.frame = self.bounds
        self.addSubview(theView)
        
        continueButton.layer.cornerRadius = 8.0
    }
    
    override func draw(_ rect: CGRect) {
        
        print("PhoneNumberInputView -> Got Called");
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
