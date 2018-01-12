//
//  CreateAccountVC.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 11/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CreateAccountVC : UserInputTextViewDelegate{
    func didBeginEnteringInTextField(enteredText: String) {
        print("didBeginEnteringInTextField(enteredText: String) Called")
    }
    
    func didRemoveTextInTextField() {
        print("didRemoveTextInTextField Called")

    }
    
    func didFinishEnteringTextInTextField(enteredText: String) {
        print("didFinishEnteringTextInTextField Called")

    }
    
    
}
