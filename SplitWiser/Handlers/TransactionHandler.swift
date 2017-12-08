//
//  TransactionHandler.swift
//  SplitWiser
//
//  Created by Moorthy, Prashanth on 12/8/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

struct TransactionHandler {
    
    static let shared = TransactionHandler()
    
    private var transactionStore = [TransactionRepresentable]()
    
    private init(){}
    
    func fetchTransaction(tranID : UUID) throws -> TransactionRepresentable?{
        
        // No Transaction found.
        guard transactionStore.isEmpty == false else {throw TransactionError.notFound}
        
        let fetchedTrans = transactionStore.filter({return ($0.getTransactionID() == tranID)})

        // No Matching Transaction found.
        guard fetchedTrans.isEmpty == false else {throw TransactionError.notFound}
        guard fetchedTrans.count == 1 else {guard TransactionError.duplicateTransaction}
        
        return fetchedTrans.first ?? nil
    }
    
    func fetchDetailsForTransactions(transactions : [UUID]) throws -> [TransactionRepresentable]? {
        do{
            for eachTransaction in transactions{
                try fetchTransaction(tranID: eachTransaction)
            }catch 

        }
        
        return nil
    }
    
}
