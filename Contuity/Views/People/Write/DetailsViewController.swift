import UIKit
import Contacts

class DetailViewController: UIViewController {

    @IBOutlet weak var contactImage: UIImageView!

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!

    var contactItem: CNContact? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let oldContact = self.contactItem {
            let store = CNContactStore()

            do {
                let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey] as [Any]
                let contact = try store.unifiedContact(withIdentifier: oldContact.identifier, keysToFetch: keysToFetch as! [CNKeyDescriptor])

                DispatchQueue.main.async(execute: { () -> Void in
                    if contact.imageDataAvailable {
                        if let data = contact.imageData {
                            self.contactImage.image = UIImage(data: data)
                        }
                    }

                    self.fullName.text = CNContactFormatter().string(from: contact)

                    self.email.text = contact.emailAddresses.first?.value as String?

                    if contact.isKeyAvailable(CNContactPostalAddressesKey) {
                        if let postalAddress = contact.postalAddresses.first?.value {
                            self.address.text = CNPostalAddressFormatter().string(from: postalAddress)
                        } else {
                            self.address.text = "No Address"
                        }
                    }
                })
            } catch {
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
