import UIKit

/// View Protocol for Writing Peoples
protocol WritePeopleViewProtocol: class {
    
}

/// View controller for writing new Peoples
class WritePeopleViewController: UIViewController {
    
    var presenter: WritePeoplePresenter = WritePeoplePresenter()
    
    @IBOutlet private (set) var textView: UITextView!
    @IBOutlet private (set) var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        presenter.attachView(self)
        prettify()
        
        navigationItem.title = "Write People"
        
        saveButton.addTarget(self, action: #selector(processTextToSave), for: .touchUpInside)
    }
    
    /// When the save button is tapped, this is triggered to notify the user they are about to save
    /// A People with new initiatives attached.
    @objc private func processTextToSave() {
        let hasNewInitiatives = presenter.update
            ? Set((People.read(givenID: presenter.PeopleID)?.data ?? "").taggedWords)
                .isSubset(of: presenter.text.taggedWords)
            : presenter.text.taggedWords.count > 0
        
        if hasNewInitiatives {
            showNewInitiativesAlert()
        } else {
            saveTextAsPeople()
        }
    }
    
    /// Saves text to the database using the presenter
    private func saveTextAsPeople() {
        presenter.savePeople()
        if presenter.update {
            navigationController?.popViewController(animated: true)
        }
        else {
            let rjvc = ReadPeopleViewController()
            rjvc.PeopleID = presenter.PeopleID
            navigationController?.pushViewController(rjvc, animated: true)
            textView.text = ""
        }
    }
}

// MARK: - WritePeopleViewProtocol
extension WritePeopleViewController: WritePeopleViewProtocol {
    
}

extension WritePeopleViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.text = textView.text
    }
}

// MARK: - Prettify
extension WritePeopleViewController: Prettify {
    func prettify() {
        saveButton.setTitle("Save!", for: .normal)
        textView.text = presenter.text
        textView.isHidden = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 22)
    }
}
