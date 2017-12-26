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
        authUI?.isSignInWithEmailHidden = true
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
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
        Database.database().reference(withPath: "people/\(user.uid)")
            .updateChildValues(["profile_picture": user.photoURL?.absoluteString ?? "",
                                "full_name": user.displayName ?? "Anonymous",
                                "_search_index": ["full_name": user.displayName?.lowercased(),
                                                  "reversed_full_name": user.displayName?.components(separatedBy: " ")
                                                    .reversed().joined(separator: "")]])
    }
    
}
