import UIKit
import Contacts

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var contact: CNContact {
        get {
            let store = CNContactStore()
            
            let contactToAdd = CNMutableContact()
            contactToAdd.givenName = self.firstName.text ?? ""
            contactToAdd.familyName = self.lastName.text ?? ""
            
            let mobileNumber = CNPhoneNumber(stringValue: (self.mobileNumber.text ?? ""))
            let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: mobileNumber)
            contactToAdd.phoneNumbers = [mobileValue]
            
            let email = CNLabeledValue(label: CNLabelHome, value: (self.homeEmail.text ?? ""))
            contactToAdd.emailAddresses = [email]
            
            if let image = self.contactImage.image {
                contactToAdd.imageData = UIImagePNGRepresentation(image)
            }
            
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(contactToAdd, toContainerWithIdentifier: nil)
            
            do {
                try store.executeSaveRequest(saveRequest)
            } catch {
                print(error)
            }
            
            return contactToAdd
        }
    }
    
    @IBOutlet weak var addImage: UIButton!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var homeEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDone(sender: AnyObject) {
        NotificationCenter.defaultCenter.postNotificationName("addNewContact", object: nil, userInfo: ["contactToAdd": self.contact])
        self.navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressAddImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismiss(animated: true, completion: nil)
        self.contactImage.image = image
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.contactImage.alpha = 1.0
            self.addImage.alpha = 0.0
        }
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
