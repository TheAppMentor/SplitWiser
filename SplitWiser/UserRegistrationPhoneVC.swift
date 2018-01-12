//
//  UserRegistrationPhoneVC.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 26/12/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import Firebase

class UserRegistrationPhoneVC: UIViewController, PhoneNumberInputViewDelegate {
    
    @IBOutlet weak var phoneNumInputView: PhoneNumberInputView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.title = "Your Phone"
        phoneNumInputView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.becomeFirstResponder()
    }
    
    
    func userEnteredPhoneNumber(thePhoneNumber: String) {
        print("We Got a phone number : \(thePhoneNumber)")
        self.processPhoneNumber(theNumber: thePhoneNumber)
    }
    
    
    func processPhoneNumber(theNumber : String) {
        
        self.view.endEditing(true)
        
        let phoneNumber = theNumber
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                //self.showMessagePrompt(error.localizedDescription)
                print("We have the bloody Error man..... \(error.localizedDescription)")
                
                return
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            self.performSegue(withIdentifier: "showVerificaitonCodeScreen", sender: self)
        }

    }
    
    
//    @IBAction func signInTheUser(sender : UIButton){
//        
//        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
//        //let verificationCode = self.codeTextField.text!
//        
//        let credential = PhoneAuthProvider.provider().credential(
//            withVerificationID: verificationID!,
//            verificationCode: verificationCode)
//        
//        Auth.auth().signIn(with: credential) { (user, error) in
//            if let error = error {
//                // ...
//                return
//            }
//            // User is signed in
//            // ...
//            print("We have signed in the bugger successfully man!")
//        }
//    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
