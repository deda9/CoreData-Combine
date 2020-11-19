//
//  ContentView.swift
//  CoreDataExample
//
//  Created by Deda on 18.11.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDataStore: CoreDataStoring = CoreDataStore.default
    @State var number_of_persons: Int
    
    var body: some View {
        Text("number of persons \(number_of_persons)")
            .padding()
        
        Button(action: addPerson) {
            Label("Add Person", systemImage: "plus")
        }.padding()
        
        Button(action: fetchPersons) {
            Text("Fetch Persons Count")
        }.padding()
        
    }
    
    private func addPerson() {
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
        coreDataStore.saveSync()
        
        fetchPersons()
    }
    
    
    private func fetchPersons() {
        let users: [Person] = coreDataStore.fectch()
        number_of_persons = users.count
    }
}
