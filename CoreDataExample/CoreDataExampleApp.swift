//
//  CoreDataExampleApp.swift
//  CoreDataExample
//
//  Created by Deda on 18.11.20.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDataStore: CoreDataStore.default)
        }
    }
}
