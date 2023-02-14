//
//  ContentView.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationView {
           
            Text("Select an item")
        }
    }

   
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        
    }
}
