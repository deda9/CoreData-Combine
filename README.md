# CoreDataExample
<img src="https://github.com/deda9/CoreData-Combine/blob/main/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20-%202020-11-19%20at%2021.00.11.png" width="300px"/>



## We learn how to save entity, delete or fetch from CoreData by Combine


## Save
```Swift
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
```

## Fetch 
```Swift
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
```

## Delete
```Swift
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
```


- You can read the tutorial on Medium [Tutorial Link](https://deda9.medium.com/ios-core-data-with-combine-c80373c5484)
