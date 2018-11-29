import Foundation
import UIKit

class ReadPeopleViewController: UIViewController {
    var PeopleID: Int = 1 // TODO: this needs to be set to the given PeopleID in a constructor
    var presenter: ReadPeoplePresenter = ReadPeoplePresenter()
    
    /// MARK - properties
    @IBOutlet private (set) var readPeopleTextView: UITextView!
    @IBOutlet private (set) var backButton: UIButton!
    @IBOutlet private (set) var editButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        prettify()
        navigationItem.title = "Read People"
    }
    // This method pushes an editable view of this People over this readable view.
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let editWritePeopleVC = WritePeopleViewController()
        editWritePeopleVC.presenter.setPeopleID(givenID: PeopleID)
        editWritePeopleVC.presenter.update = true
        navigationController?.pushViewController(editWritePeopleVC, animated: true)
    }
    // This method pops this view off of the stack, thus going back to the previous view.
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ReadPeopleViewController: Prettify {
    func prettify() {
        readPeopleTextView.text = presenter.getText(PeopleID: self.PeopleID)
        readPeopleTextView.isHidden = false
        readPeopleTextView.isEditable = false
        readPeopleTextView.font = .systemFont(ofSize: 22)
    }
}
