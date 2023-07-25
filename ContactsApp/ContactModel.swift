//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Ecem Öztürk on 25.07.2023.
//

import Foundation

struct ContactModel {
    var name: String
    var photo: String
    var contactType: ContactType
}

enum ContactType : CaseIterable {
    case family
    case friends
    case work
    
    var contactType: String {
        switch self {
        case .family:
            return "Family"
        case .friends:
            return "Friends"
        case .work:
            return "Work"
            
        }
    }
}

class Contacts {
    static let contacts: [ContactModel] = [
        ContactModel(name: "Robin", photo: "robin", contactType: .friends),
        ContactModel(name: "Ted", photo: "ted", contactType: .friends),
        ContactModel(name: "Lily", photo: "lily", contactType: .family),
        ContactModel(name: "Marshall", photo: "marshall", contactType: .family),
        ContactModel(name: "Victoria", photo: "victoria", contactType: .work),
        ContactModel(name: "Barney", photo: "barney", contactType: .work),
        ContactModel(name: "Quinn", photo: "quinn", contactType: .friends)
    ]
}
