//
//  TextFieldView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI

struct TextFieldView<Content:View> : View {
    
    enum FieldType {
        case text, secure
    }
    
    @Binding
    var text: String
    
    let content: Content
    var title: String
    var placeholder: String
    var type: FieldType
    var keyboardType: UIKeyboardType?
    
    init(text: Binding<String>,
         title: String,
         placeholder: String,
         type: FieldType,
         keyboardType: UIKeyboardType?=nil,
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.type = type
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(FontManager.font(size: 15, weight: .extrabold))
                .foregroundColor(Color(hex: "#191919"))
                .padding(.bottom, 6)
            textFields
                .frame(height: 24)
                .font(FontManager.font(size: 15, weight: .medium))
            RoundedRectangle(cornerRadius: 0.5)
                .foregroundColor(Color(hex: "#999999"))
                .frame(height: 2)
        }
    }
    
    private var textFields: some View {
        HStack(spacing: 0) {
            switch self.type {
            case .text:
                if let keyboardType = keyboardType {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(keyboardType)
                } else {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            case .secure:
                SecureField(placeholder, text: $text)
            }
            content
        }
    }
    
}

extension TextFieldView where Content == EmptyView {
    
    init(text: Binding<String>, title: String, placeholder: String, type: FieldType, keyboardType: UIKeyboardType?=nil) {
        self.init(text: text, title: title, placeholder: placeholder, type: type, keyboardType: keyboardType, content: { EmptyView() })
    }
    
}
