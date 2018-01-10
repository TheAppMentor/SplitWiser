//
//  UserTests.swift
//  SplitWiserTests
//
//  Created by Raghu, Reshma L on 1/8/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import XCTest
@testable import SplitWiser

class UserTests: XCTestCase {

	override func setUp() {
		super.setUp()
		print("----------------------------")
		print("      USER TESTS           ")
		print("----------------------------")
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	/*func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}*/

	func testFetchUserBasedOnId() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Fetch user")

		UserManager().getUserWith(userID: "wRK8UEBMhlRXICj5qZncWJBCIxk2", completionHandler: {(user, userError) in
			XCTAssertNil(userError, "❌ User error : \(String(describing: userError?.localizedDescription))")
			if userError == nil {
				print("✅ User for the ID is: \(String(describing: user?.userName))")
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			}
		})
		// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
		self.wait(for: [expectation], timeout: 300.0)
	}

	func testFetchUserBasedOnPhoneNumber() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Fetch user")

		UserManager().getUserWith(phoneNumber: "+919632599369", completionHandler: {(user, userError) in
			XCTAssertNil(userError, "❌ User error : \(String(describing: userError?.localizedDescription))")
			if userError == nil {
				print("✅ User for the phone number is: \(String(describing: user?.userName))")
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			}
		})
		// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
		self.wait(for: [expectation], timeout: 300.0)
	}

	func testCurrentLoggedInUser() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Current logged-in user")

		UserManager().currentLoggedInUser(completionHandler: {(user, userError) in
			XCTAssertNil(userError, "❌ User error : \(String(describing: userError?.localizedDescription))")
			if userError == nil {
				print("✅ Current logged-in user is: \(String(describing: user?.userName))")
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			}
		})
		// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
		self.wait(for: [expectation], timeout: 300.0)
	}

	func testRegisterUser() {
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Current logged-in user")

		UserManager().registerUser(userName: "Pavan K S", email: "pavankowshik@gmail.com", phoneNumber: "+918197290734", completionHandler: {(success) in
			XCTAssert(success, "❌ User error : Failed to create user")
			if success {
				// Fulfill the expectation to indicate that the background task has finished successfully.
				expectation.fulfill()
			}
		})
		// Wait until the expectation is fulfilled, with a timeout of 5 seconds.
		self.wait(for: [expectation], timeout: 300.0)
	}
}
