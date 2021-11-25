//
//  RoomView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import SwiftUI

struct RoomView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var body: some View {
        VStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 17)
                    .foregroundColor(Color(hex: "#191919"))
            }
            Spacer()
            Button {
                
            } label: {
                Text("약속 정하기")
            }

        }
    }
    
}
