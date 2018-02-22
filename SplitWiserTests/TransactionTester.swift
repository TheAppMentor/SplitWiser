//
//  TransactionTester.swift
//  SplitWiserTests
//
//  Created by Moorthy, Prashanth on 12/10/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import XCTest
@testable import SplitWiser

class TransactionTester: XCTestCase {

    var tranMan = TransactionManager.shared
    let eventMan = EventManager()
    var userList = [String]()
    var eventList = [Event]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
		userList.append("+919632599369")
		userList.append("+918197290734")

        var lunchEvent = Event(name: "Lunch-with-team", description: "God, yet another Lunch!", createdBy: "+919632599369", members: userList)
		lunchEvent.eventId = "-L5vtTsRuHI5amcWi7zY"
        var movieEvent = Event(name: "Movie-with-team", description: "Wonder woman", createdBy: "+919632599369", members: userList)
        movieEvent.eventId = "-L5vwqviPc9QdDPt8Uc9"
        eventList.append(lunchEvent)
        eventList.append(movieEvent)
    }

    //MARK: Add Transactions Test
    
    func testAddTransaction() {
        do{
			if let addedTran = try tranMan.addTransaction(date: Date().timeIntervalSince1970, associatedEvent: (eventList.first?.eventId)!, status: .pending, paidBy: userList.first!, paidFor: [], amount: 100, currency: .Rupee, transactionImages: nil, transactionDescription: "test transact"){
                do {
                    if let fetchedTran = try tranMan.fetchTransaction(tranID: addedTran.tranID){
                        XCTAssert(true, "Transaction Added Successfully")
                    }
                }catch{
                    XCTAssert(false, "Failed to Add Transaction")
                }
            }
        }catch{
            XCTAssert(false, "Failed to Add Transaction")
        }
    }
    
    /*func testTotalAmount(){
        do{
            let tranMan = try TransactionManager.shared.fetchTransaction(tranID: UUID())
            XCTAssert(true, "Simply Fail")
        }catch{
            print("Some Error \(error)")
        }
    }*/
    
}
