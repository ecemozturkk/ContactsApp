//
//  ViewController.swift
//  ContactsApp
//
//  Created by Ecem Öztürk on 25.07.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var selectedContactType: ContactType? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), style: .done, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonTapped() {
        let storyboard = UIStoryboard(name: "PickerViewController", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "PickerViewController") as? PickerViewController {
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }
}

// MARK: - PickerViewController Delegate Methods
extension ViewController: PickerViewControllerDelegate {
    func didSelectContactType(_ type: ContactType) {
        selectedContactType = type
    }
}

// MARK: - TableView Delegate Methods
//Delegate yapısı tetikleme-aksiyonlarla, DataSource yapısı içeriği ile ilgilidir
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                    if let selectedContactType = selectedContactType {
//                        return Contacts.contacts.filter({ $0.contactType == selectedContactType }).count
//                    } else {
//                        let contactType = ContactType.allCases[section]
//                        return Contacts.contacts.filter({ $0.contactType == contactType }).count
//                    }
        return filterContacts(section).count


    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
//           if let selectedContactType = selectedContactType {
//               let filteredContacts = Contacts.contacts.filter({ $0.contactType == selectedContactType })
//               cell.cellImage.image = UIImage(named: filteredContacts[indexPath.row].photo)
//               cell.nameLbl.text = filteredContacts[indexPath.row].name
//           } else {
//               let contactType = ContactType.allCases[indexPath.section]
//               let filteredContacts = Contacts.contacts.filter({ $0.contactType == contactType })
//               cell.cellImage.image = UIImage(named: filteredContacts[indexPath.row].photo)
//               cell.nameLbl.text = filteredContacts[indexPath.row].name
//           }
//           return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        
        cell.cellImage.image = UIImage(named: filterContacts(indexPath.section)[indexPath.row].photo)
        cell.nameLbl.text = filterContacts(indexPath.section)[indexPath.row].name
        return cell
       }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return ContactType.allCases.count
        return setSections().count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let contactType = ContactType.allCases[section]
//        let filteredContacts = Contacts.contacts.filter({ $0.contactType == contactType })
//        return filteredContacts.isEmpty ? nil : contactType.contactType
        return setSections()[section].contactType

    }

    
    private func setSections() -> [ContactType] {
        if selectedContactType == nil {
            return ContactType.allCases
        } else {
            return [selectedContactType!]
        }
    }
    
    private func filterContacts(_ sectionIndex: Int) -> [ContactModel] {
        if selectedContactType == nil {
            return Contacts.contacts.filter({ $0.contactType == ContactType.allCases[sectionIndex] })
        } else {
            return Contacts.contacts.filter({ $0.contactType == selectedContactType })
        }
    }

    
}

