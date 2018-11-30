import Foundation
import UIKit

protocol WritePeoplePresenterProtocol: PresenterProtocol {
    /// Text body that needs to be saved as the People
    var text: String { get set }
    
    /// If true, then this WritePeoplePresenter is updating an existing People
    var update: Bool { get set }
    
    /// The id of the People being written or updated
    var peopleID: Int { get set }
    
    /// Creates a People using the text and writes to the database.
    ///
    func savePeople(email: String?, number: String?)
    
    /// Sets the id of this presenter to the given id
    ///
    /// - Parameters:
    ///   - givenID: the id that this id should be set to
    func setPeopleID(givenID: Int)
}

class WritePeoplePresenter: WritePeoplePresenterProtocol {
    var text: String = ""
    var update: Bool = false
    var email: String = ""
    var number: String = ""
    var peopleID: Int = Int.random(in: 0...1000000)
    
    var view: WritePeopleViewProtocol?
    
    func attachView(_ view: WritePeopleViewProtocol?) {
        self.view = view
    }
    
    func savePeople(email: String?, number: String?) {
        if update {
            guard let updatePeople = People.read(givenID: peopleID) else {
                return
            }
            updatePeople.update()
        }
        else {
            self.peopleID = People.nextId
            let people =  People(id: peopleID,
                                 name: text,
                                 number: number,
                                 email: email,
                                 createdat: Date().timestamp())
            
            people.write()
        }
    }
    
    /// This method sets the id of the given People.
    func setPeopleID(givenID: Int) {
        self.peopleID = givenID
        self.text = People.read(givenID: givenID)?.name ?? ""
    }
}
