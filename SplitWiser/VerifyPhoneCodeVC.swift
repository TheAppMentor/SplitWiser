//
//  VerifyPhoneCodeVC.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 10/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class VerifyPhoneCodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func verifyEnteredCode(sender : UIButton){
        
        // If valid Code.
        performSegue(withIdentifier: "createUserScreen", sender: self)
        
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
