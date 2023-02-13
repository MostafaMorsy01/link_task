//
//  link_taskApp.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

@main
struct link_taskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
