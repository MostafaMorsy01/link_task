//
//  link_taskApp.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

@main
struct link_taskApp: App {
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }

}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
#endif
