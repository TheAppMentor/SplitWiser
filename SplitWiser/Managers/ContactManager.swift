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
    
    func fetchAllContacts() -> [CNContact] {
        
        var results: [CNContact] = []
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor,CNContactImageDataKey as CNKeyDescriptor])
        
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        
        let store = CNContactStore()
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                if let thePhoneNum = contact.phoneNumbers.first?.value{
                    print("\(contact.givenName) -----> \(thePhoneNum.stringValue)")
                }else {
                    print("\(contact.givenName) -----> Number Not found")
                }
                results.append(contact)
                
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return results
        
//        let contactStore = CNContactStore()
//        let keys = [CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey] as [CNKeyDescriptor]
//        let request = CNContactFetchRequest(keysToFetch: keys)
//        
//        try? contactStore.enumerateContacts(with: request) { (contact, error) in
//            
//            contact.phoneNumbers.forEach({print($0.label)})
//            
//            // Do something with contact
//            //print("Fetched : \(contact.phoneNumbers)")
//            
//        }
        
        
//        let store = CNContactStore()
//        let contacts = try! store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: "Sheia"), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor])
//        print("All Contacts are : \(contacts)")
    }
}
