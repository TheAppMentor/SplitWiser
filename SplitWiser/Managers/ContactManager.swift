//
//  ContactManager.swift
//  SplitWiser
//
//  Created by Prashanth Moorthy on 02/01/18.
//  Copyright © 2018 Santebidanur Nagaraja, Pavan Kowshik. All rights reserved.
//

import Foundation
import Contacts

class ContactManager {
    
    func fetchAllContacts() {
        
        let contactStore = CNContactStore()
        let keys = [CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        try? contactStore.enumerateContacts(with: request) { (contact, error) in
            
            contact.phoneNumbers.forEach({print($0.label)})
            
            // Do something with contact
            //print("Fetched : \(contact.phoneNumbers)")
            
        }
        
        
//        let store = CNContactStore()
//        let contacts = try! store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: "Sheia"), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor])
//        print("All Contacts are : \(contacts)")
    }
}
