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
    var userList = [SplitWiserUser]()
    var eventList = [Event]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let userPavan = SplitWiserUser(phoneNumber: "1111111", userName: "Pavan", profileImage: nil, email: nil, transactionsProvider: tranMan, eventsProvider: eventMan)
        let userReshma = SplitWiserUser(phoneNumber: "222222", userName: "Reshma", profileImage: nil, email: nil, transactionsProvider: tranMan, eventsProvider: eventMan)
        let userPrashanth = SplitWiserUser(phoneNumber: "333333", userName: "Prashanth", profileImage: nil, email: nil, transactionsProvider: tranMan, eventsProvider: eventMan)
        let userJagan = SplitWiserUser(phoneNumber: "444444", userName: "Jagan", profileImage: nil, email: nil, transactionsProvider: tranMan, eventsProvider: eventMan)
        
        userList.append(userPavan)
        userList.append(userReshma)
        userList.append(userPrashanth)
        userList.append(userJagan)
        
        //let lunchEvent = Event(eventId: UUID(), name: "Lunch", description: "Lunch Description", date: Date(), createdBy: userPavan, transactions: [])
        //let movieEvent = Event(eventId: UUID(), name: "Movie", description: "Movie Description", date: Date(), createdBy: userPavan, transactions: [])
        let lunchEvent = Event(eventId: UUID(), name: "Lunch", description: "Lunch Description", date: Date().timeIntervalSinceNow)
        let movieEvent = Event(eventId: UUID(), name: "Movie", description: "Movie Description", date: Date().timeIntervalSinceNow)

        //        let lunchEvent = EventManager().createEvent(name: "Lunch", description: "Lunch Description")
//        let movieEvent = EventManager().createEvent(name: "Movie", description: "Movie Description")
        
        eventList.append(lunchEvent)
        eventList.append(movieEvent)
    }
    
    
    //MARK: Add Transactions Test
    
    func testAddTransaction() {
        do{
            if let addedTran = try tranMan.addTransaction(date: Date(), associatedEvent: eventList.first!, status: .pending, paidBy: userList.first!, paidFor: [], amount: 100, currency: .Rupee, transactionImages: nil, transactionDescription: "Simple Transaction"){
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

    
    
    func testTotalAmount(){
        do{
            let tranMan = try TransactionManager.shared.fetchTransaction(tranID: UUID())
            XCTAssert(true, "Simply Fail")
        }catch{
            print("Some Error \(error)")
        }
    }
    
}
