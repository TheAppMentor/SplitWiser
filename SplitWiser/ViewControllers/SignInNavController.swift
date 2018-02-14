//
//  SignInVC.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/9/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebasePhoneAuthUI

private let kFirebaseTermsOfService = URL(string: "https://firebase.google.com/terms/")!

class SignInNavController: UINavigationController, FUIAuthDelegate {
    
    fileprivate(set) var authUI: FUIAuth?
    fileprivate var authStateDidChangeHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidAppear(_ animated: Bool) {

		super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
//            self.navigationBar.isHidden = false
//            self.performSegue(withIdentifier: "showEvents", sender: nil)
            return
        }
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        authUI?.tosurl = kFirebaseTermsOfService
		let providers: [FUIAuthProvider] = [FUIPhoneAuth(authUI: authUI!), FUIGoogleAuth()]
        authUI?.providers = providers
        let authViewController: UINavigationController? = authUI?.authViewController()
        authViewController?.navigationBar.isHidden = true
        present(authViewController!, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        switch error {
        case .some(let error as NSError) where UInt(error.code) == FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in")
        case .some(let error as NSError) where error.userInfo[NSUnderlyingErrorKey] != nil:
            print("Login error: \(error.userInfo[NSUnderlyingErrorKey]!)")
        case .some(let error):
            print("Login error: \(error.localizedDescription)")
        case .none:
            if let user = user {
                signed(in: user)
            }
        }
    }
    
    func signed(in user: User) {
		print("🙏🏻 Welcome --- \(String(describing: user.displayName))")
		UserManager().getUserWith(userID: user.phoneNumber!, completionHandler: {(splitWiserUser, error) in
			if error == nil {
				//TODO: This means user exists, we need to ask him to update displaname/profilepic/emailId/whatever
			} else {
				UserManager().registerUser(userName: user.displayName ?? "Anonymous", email: user.email ?? "", phoneNumber: user.phoneNumber!,  completionHandler: {(success) in
					print("---------- REGISTERED!")
				})
			}
		})
    }
    
}
