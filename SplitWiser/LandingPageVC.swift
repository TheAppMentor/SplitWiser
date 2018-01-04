//
//  LandingPageVC.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 26/12/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit
import Firebase

class LandingPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showSignUpPage(_ sender: UIButton){
        self.performSegue(withIdentifier: "showSignUpPage", sender: nil)        
    }
    
    @IBAction func loginToApp(_ sender: UIButton) {

        self.performSegue(withIdentifier: "showEvents", sender: nil)
        
//        if Auth.auth().currentUser != nil {
//            self.navigationBar.isHidden = false
//            return
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
