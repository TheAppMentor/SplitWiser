//
//  UserInputTextViewDelegate.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 11/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation


@objc protocol UserInputTextViewDelegate {
    func didBeginEnteringInTextField(enteredText : String)
    func didRemoveTextInTextField()
    func didFinishEnteringTextInTextField(enteredText : String)
}
