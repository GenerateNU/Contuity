import Foundation
import UIKit

protocol WritePeoplePresenterProtocol: PresenterProtocol {
    /// Text body that needs to be saved as the People
    var text: String { get set }
    
    /// If true, then this WritePeoplePresenter is updating an existing People
    var update: Bool { get set }
    
    /// The id of the People being written or updated
    var PeopleID: Int { get set }
    
    /// Creates a People using the text and writes to the database.
    ///
    func savePeople(name: String?, email: String?, number: String?)
    
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
    var PeopleID: Int = Int.random(in: 0...1000000)
    
    var view: WritePeopleViewProtocol?
    
    func attachView(_ view: WritePeopleViewProtocol?) {
        self.view = view
    }
    
    func savePeople(lat: Double? = nil, lng: Double? = nil) {
        if update {
            guard let updatePeople = People.read(givenID: PeopleID) else {
                return
            }
            updatePeople.update()
        }
        else {
            self.PeopleID = People.nextId
            let People =  People(id: PeopleID,
                                 name: text,
                                 createdat: Date().timestamp(),
                                 number: number,
                                 email: email)
            
            People.write()
        }
        
        createInitiatives(with: self.PeopleID)
    }
    
    private func createInitiatives(with PeopleId: Int) {
        let initiatives: [Initiative] = text.taggedWords.map { value -> Initiative in
            return Initiative(name: value, parent: nil)
        }
        
        initiatives.forEach { initiative in
            initiative.write()
            
            let bridge = PeopleInitiative(PeopleId: PeopleId, initiativeTag: initiative.name)
            bridge.write()
        }
    }
    
    /// This method sets the id of the given People.
    func setPeopleID(givenID: Int) {
        self.PeopleID = givenID
        self.text = People.read(givenID: givenID)?.data ?? ""
    }
}
