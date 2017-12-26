//
//  EventTests.swift
//  SplitWiserTests
//
//  Created by Raghu, Reshma L on 12/10/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import XCTest
import Firebase
import FirebaseAuth
@testable import SplitWiser

class EventTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
		print("----------------------------")
		print("      EVENT TESTS           ")
		print("----------------------------")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

	func testEventCreation() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Create event")

		if let u = Auth.auth().currentUser {
			print("🙏🏻 Welcome - \(String(describing: u.displayName))")
			let user = SplitWiserUser(uid: u.uid, phoneNumber: u.phoneNumber ?? "", userName: u.displayName!, profileImage: nil, email: u.email, transactionsProvider: TransactionManager.shared, eventsProvider: EventManager())
			EventManager().createEvent(name: "Lunch@SomeDarnPlace", user: user, completionHandler: {(event, error) in

				XCTAssertNil(error)
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			})
			// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
			wait(for: [expectation], timeout: 5.0)
		}
	}

	func testEventDeletion() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Delete event")

		if let u = Auth.auth().currentUser {
			print("🙏🏻 Welcome - \(String(describing: u.displayName))")
			let user = SplitWiserUser(uid: u.uid, phoneNumber: u.phoneNumber ?? "", userName: u.displayName!, profileImage: nil, email: u.email, transactionsProvider: TransactionManager.shared, eventsProvider: EventManager())
			var event = Event(name: "Lunch@SomeDarnPlace", createdBy: user)
			event.eventId = "-L1GNc_hUSIR9siA8cm5"
			EventManager().deleteEvent(event: event, completionHandler: {(error) in

				XCTAssertNil(error)
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			})
			// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
			wait(for: [expectation], timeout: 5.0)
		}
	}

	func testFetchEvents() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Fetch events")

		if let u = Auth.auth().currentUser {
			print("🙏🏻 Welcome - \(String(describing: u.displayName))")
			let user = SplitWiserUser(uid: u.uid, phoneNumber: u.phoneNumber ?? "", userName: u.displayName!, profileImage: nil, email: u.email, transactionsProvider: TransactionManager.shared, eventsProvider: EventManager())
			EventManager().fetchEventsFor(user: user, completionHandler: {(events, error) in

				XCTAssertNil(error)
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			})
			// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
			wait(for: [expectation], timeout: 30.0)
		}
	}
    
}
