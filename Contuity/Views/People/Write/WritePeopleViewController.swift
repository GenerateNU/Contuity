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
        
        saveButton.addTarget(self, action: #selector(saveTextAsPeople), for: .touchUpInside)
    }
    
    /// Saves text to the database using the presenter
    @objc private func saveTextAsPeople() {
        presenter.savePeople(email: "", number: "")
        if presenter.update {
            navigationController?.popViewController(animated: true)
        }
        else {
            let rjvc = ReadPeopleViewController()
            rjvc.peopleID = presenter.peopleID
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
