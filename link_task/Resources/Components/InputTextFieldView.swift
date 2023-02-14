//
//  InputTextFieldView.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

struct InputTextField: View {
    let screenWidth = UIScreen.main.bounds.width
    @State var placeHolder: String
    @Binding var text:String
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Rectangle()
                        .frame(width: 5,height: 50)
                        .foregroundColor(.gray)
                    TextField(placeHolder, text: $text)
                        .padding(5)
                        .frame(width: screenWidth - 70,height: 50)
                    
                }
                .background(Color.gray.opacity(0.2))
            }
            
            
            .padding(10)
        }
    }
}
