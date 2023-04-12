//
//  Cart_CrunchApp.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/11/23.
//

import SwiftUI

@main
struct Cart_CrunchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
