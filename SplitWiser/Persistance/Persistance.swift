//
//  Persistance.swift
//  SplitWiser
//
//  Created by Raghu, Reshma L on 12/16/17.
//  Copyright © 2017 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation

protocol Persistance {
	func create()
	func retrieve()
	func update()
	func delete()
}
