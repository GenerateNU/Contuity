import Foundation

/// This protocol represents the protocol for a read People presenter
protocol ReadPeoplePresenterProtocol: PresenterProtocol {
    /// returns the text to be displayed by this ReadPeople
    func getText(PeopleID: Int) -> String
}

/// This class represents a read People presenter
class ReadPeoplePresenter: ReadPeoplePresenterProtocol {
    weak var view: ReadPeopleViewController?
    func attachView(_ view: ReadPeopleViewController?) {
        self.view = view
    }
    /// this method returns the text at the given id.
    func getText(PeopleID: Int) -> String {
        guard let readPeople = People.read(givenID: PeopleID) else {
            return "ERROR: could not retrieve People."
        }
        return readPeople.name
    }
}
