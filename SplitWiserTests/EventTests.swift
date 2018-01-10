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
			UserManager().getUserWith(userID: "+919632599369", completionHandler: {(user, userError) in
				if userError == nil {
					UserManager().getUserWith(userID: "+918197510162", completionHandler: {(member, userError) in
					let members = [member]
					EventManager().createEvent(name: "Lunch-with-jagan", description: "God, yet another Lunch!", user: user!, members: members as? [SplitWiserUser], completionHandler: {(event, eventError) in
						XCTAssertNil(eventError, "❌ Event error : \(String(describing: eventError?.localizedDescription))")
						// Fulfill the expectation to indicate that the background task has finished successfully.
						expectation.fulfill()
					})
					})
				}
				XCTAssertNil(userError, "❌ User error : \(String(describing: userError?.localizedDescription))")
			})
			// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
			self.wait(for: [expectation], timeout: 300.0)
		}
	}

	func testEventDeletion() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Delete event")

		if let u = Auth.auth().currentUser {
			let user = SplitWiserUser(phoneNumber: u.phoneNumber!, userName: u.displayName!, profileImage: nil, email: u.email!)
			var event = Event(name: "Lunch@SomeDarnPlace", createdBy: user.uid)
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
			UserManager().getUserWith(userID: u.uid, completionHandler: {(user, userError) in
				if userError == nil {
					EventManager().fetchEventsFor(user: user!, completionHandler: {(events, eventError) in
						print(events)
						XCTAssertNil(eventError, "❌ Event error : \(String(describing: eventError?.localizedDescription))")
						// Fulfill the expectation to indicate that the background task has finished successfully.
						expectation.fulfill()
					})
				}
				XCTAssertNil(userError, "❌ User error : \(String(describing: userError?.localizedDescription))")
			})
			// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
			wait(for: [expectation], timeout: 5.0)
		}
	}

}
