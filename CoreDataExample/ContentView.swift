import SwiftUI
import CoreData
import Combine

var bag: [AnyCancellable] = []

struct ContentView: View {
    let coreDataStore: CoreDataStoring!
    
    @State private var number_of_persons: Int = 0
    @State private var message: String = "None"
    
    var body: some View {
        Text("Message")
        Text("\(message)").foregroundColor(.green)
        Text("number of persons \(number_of_persons)")
            .padding()
        
        Button(action: addPerson) {
            Label("Add Person", systemImage: "plus")
        }.padding()
        
        Button(action: fetchPersons) {
            Text("Fetch Persons Count")
        }.padding()
        
        Button(action: deleteAllPersons) {
            Text("Delte All Persons")
        }.padding()
        
    }
    
    private func addPerson() {
        let action: Action = {
            let bezo: Person = coreDataStore.createEntity()
            bezo.first_name = "Bezo"
            bezo.last_name = "Deda"
            
            let volksCar: Car = coreDataStore.createEntity()
            volksCar.name = "Volkswagen"
            volksCar.owner = bezo
            
            let bmwCar: Car = coreDataStore.createEntity()
            bmwCar.name = "BMW"
            bmwCar.owner = bezo
            
            bezo.cars = [volksCar, bmwCar]
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    message = error.localizedDescription
                }
            } receiveValue: { success in
                if success {
                    message = "Saving entities succeeded"
                    number_of_persons += 1
                }
            }
            .store(in: &bag)
    }
    
    private func fetchPersons() {
        let request = NSFetchRequest<Person>(entityName: Person.entityName)
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    message = error.localizedDescription
                }
            } receiveValue: { persons in
                message = "Fetching entities succeeded"
                number_of_persons = persons.count
            }
            .store(in: &bag)
    }
    
    private func deleteAllPersons() {
        let request = NSFetchRequest<Person>(entityName: Person.entityName)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    message = error.localizedDescription
                }
            } receiveValue: { _ in
                message = "Deleting entities succeeded"
                number_of_persons = 0
            }
            .store(in: &bag)
        
    }
}
