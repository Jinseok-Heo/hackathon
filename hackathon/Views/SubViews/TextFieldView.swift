//
//  TextFieldView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI

struct TextFieldView: View {
    
    enum FieldType {
        case text, secure
    }
    
    @Binding
    var text: String
    
    var title: String
    var placeholder: String
    var type: FieldType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(FontManager.font(size: 15, weight: .extrabold))
                .foregroundColor(Color(hex: "#999999"))
                .padding(.bottom, 6)
            content
                .frame(height: 24)
                .font(FontManager.font(size: 15, weight: .medium))
            Rectangle()
                .foregroundColor(Color(hex: "#C5C5C5"))
                .frame(height: 2)
        }
    }
    
    @ViewBuilder private var content: some View {
        switch self.type {
        case .text:
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        case .secure:
            SecureField(placeholder, text: $text)
        }
    }
    
}
