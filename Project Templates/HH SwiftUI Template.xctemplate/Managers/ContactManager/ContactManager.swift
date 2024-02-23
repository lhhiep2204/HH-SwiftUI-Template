//___FILEHEADER___

import Contacts

class ContactManager: NSObject {
    // MARK: - Properties
    static let shared = ContactManager()

    private let store = CNContactStore()
}

// MARK: - Methods
extension ContactManager {
    var authorizationStatus: CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: .contacts)
    }

    func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        store.requestAccess(for: .contacts) { isGrant, error in
            completion(isGrant, error)
        }
    }

    func fetchContact() {
        let keys = [
            CNContactImageDataKey,
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
        ]

        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

        do {
            try store.enumerateContacts(with: request, usingBlock: { contact, pointer in
                print("ContactManager fetchContact", contact)
            })
        } catch let error {
            print("ContactManager fetchContact error: \(error.localizedDescription)")
        }
    }

    func addContact(_ contact: CNMutableContact) {
        let request = CNSaveRequest()

        request.add(contact, toContainerWithIdentifier: nil)

        do {
            try store.execute(request)
            print("ContactManager addContact success")
        } catch let error {
            print("ContactManager addContact error: \(error.localizedDescription)")
        }
    }

    func deleteContact(byId id: String) {
        let predicate = CNContact.predicateForContacts(withIdentifiers: [id])
        let keys = [CNContactPhoneNumbersKey as CNKeyDescriptor]

        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)

            guard let contact = contacts.first else {
                print("ContactManager deleteContact no contact found")
                return
            }

            let request = CNSaveRequest()
            let mutableContact = contact.mutableCopy() as! CNMutableContact

            request.delete(mutableContact)

            do {
                try store.execute(request)
                print("ContactManager deleteContact success")
            } catch let error {
                print("ContactManager deleteContact error: \(error.localizedDescription)")
            }
        } catch let error {
            print("ContactManager deleteContact unifiedContacts error: \(error.localizedDescription)")
        }
    }
}
