//
//  TransactionDelegate.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/9/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

// Reshma, Pavan :
// For any operation related to transaction, please add your required methods here..
// I will add the implementation.

protocol TransactionDelegate {
    
    func someSampleMethod()
    func fetchAllTransactionsForEvent(event : Event) -> [TransactionRepresentable]?
    func fetchAllTransactionsFor(event : Event, user : SplitWiserUser) -> [TransactionRepresentable]?
}


extension TransactionDelegate {
    
    func someSampleMethod(){
        // Empty Implementation, Prashanth will implement.
    }
    
    func fetchAllTransactionsFor(event : Event, user : SplitWiserUser) -> [TransactionRepresentable]?{
        if let allTrans = fetchAllTransactionsForEvent(event: event){
            let allTransForUser = allTrans.filter({return $0.getPaidBy() == user})
        }
        return nil
    }
    
}
