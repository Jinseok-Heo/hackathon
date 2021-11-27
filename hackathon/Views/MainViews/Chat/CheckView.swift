//
//  CheckView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI

struct CheckView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State
    var buttonAction: Bool = false
    
    let mento: Mento
    
    init(mento: Mento) {
        self.mento = mento
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: MyTabView(), isActive: $buttonAction) { EmptyView() }
            Spacer()
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 140, height: 140)
                .foregroundColor(.green)
            Text("멘토링이 확정되었습니다")
                .font(FontManager.font(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#191919"))
            Spacer()
            Button {
                self.buttonAction = true
//                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("돌아가기")
                    .foregroundColor(Color(hex: "#191919"))
                    .font(FontManager.font(size: 17, weight: .medium))
                    .padding([.top, .bottom])
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(Color("secondColor"))
                    )
            }
            .padding([.leading, .trailing], 22)
            .padding(.bottom, 10)
        }
        .navigationBarHidden(true)
    }
    
}
