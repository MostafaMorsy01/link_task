//
//  LoginHeaderView.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import SwiftUI

struct LoginHeaderView: View {
    @State var rectSize: CGFloat = .zero
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    Image("logo")
                    Spacer()
                }
                Divider()
                    .frame(width: rectSize,height: 0.2)
                    .background(Color.gray)
            }
        }
    }
}


