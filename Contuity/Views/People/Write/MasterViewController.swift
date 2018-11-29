import UIKit
import Contacts
import ContactsUI

class MasterViewController: UITableViewController, CNContactPickerDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addExisting = UIBarButtonItem(title: "Add Existing", style: .plain, target: self, action: Selector(("addExistingContact")))
        self.navigationItem.leftBarButtonItem = addExisting
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController // swiftlint:disable:this force_cast
        }

        NotificationCenter.default.addObserver(self, selector: Selector(("insertNewObject:")),
                                               name: NSNotification.Name(rawValue: "addNewContact"), object: nil)
        self.getContacts()
    }

    func getContacts() {
        let store = CNContactStore()
        func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                completionHandler(true)
            case .restricted, .notDetermined:
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        completionHandler(true)
                    }
                }
            case .denied:
                completionHandler(false)
            }
        }
    }

    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            let groups = try store.groups(matching: nil)
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey] as [Any]

            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor]) // swiftlint:disable:this force_cast
            self.objects = contacts
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        } catch {
            print(error)
        }
    }

    func addExistingContact() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }

    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addNewContact"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: NSNotification) {
        if let contact = sender.userInfo?["contactToAdd"] as? CNContact {
            objects.insert(contact, at: 0)
            let indexPath = NSIndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }

    // MARK: - Segues
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController // swiftlint:disable:this force_cast
                controller.contactItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)

        let contact = self.objects[indexPath.row]
        let formatter = CNContactFormatter()

        cell.textLabel?.text = formatter.string(from: contact)
        cell.detailTextLabel?.text = contact.emailAddresses.first?.value as String?

        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
