//
//  MoreRectangleBar.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MoreRectangleBar: View {

    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Button {
            // TODO: Make action for button
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(hex: "#ECECEC"))
                Text(text)
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                    .foregroundColor(Color(hex: "#555555"))
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .padding(.trailing, 22)
            .frame(height: 36)
        }

    }
}
