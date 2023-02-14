//
//  SplashScreenView.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        
        if isActive == true {
            LoginView()
        } else {
            ZStack {
                Color.white
                  .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Image("logo")
                            .font(.system(size: 100))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                        self.isActive = true
                    })
                })
               
            }
        }
        
        
        
        
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
