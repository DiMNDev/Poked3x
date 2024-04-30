//
//  PokeD3XApp.swift
//  PokeD3X
//
//  Created by Joshua Arnold on 4/30/24.
//

import SwiftUI

@main
struct PokeD3XApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
