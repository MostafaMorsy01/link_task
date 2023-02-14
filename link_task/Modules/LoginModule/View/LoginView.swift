//
//  LoginView.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

struct LoginView: View {
    @State var text: String = ""
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LoginHeaderView(rectSize: geometry.size.width)
                
                VStack{
                    HStack {
                        Text("Login")
                            .font(.title.bold())
                    }
                }
                
                InputTextField(placeHolder: "Email Address", text: $text)
                InputTextField(placeHolder: "Password", text: $text)
                
                ZStack {
                    Button(action: {}, label: {
                        Text("Continue")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                    })
                    .frame(width: screenWidth - 100)
                    .background(text == "" ? Color("button").opacity(0.2) : Color("button"))
                    .cornerRadius(30)
                    .padding(10)
                    .shadow(radius: 5)
                    .disabled(text == "")
                }
                
            }
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
           
    }
}



