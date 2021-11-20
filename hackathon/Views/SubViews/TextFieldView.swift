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
    
    init(text: Binding<String>, title: String, placeholder: String, type: FieldType, @ViewBuilder content: () -> Content) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.type = type
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(FontManager.font(size: 15, weight: .extrabold))
                .foregroundColor(Color(hex: "#999999"))
                .padding(.bottom, 6)
            textFields
                .frame(height: 24)
                .font(FontManager.font(size: 15, weight: .medium))
            Rectangle()
                .foregroundColor(Color(hex: "#C5C5C5"))
                .frame(height: 2)
        }
    }
    
    private var textFields: some View {
        HStack(spacing: 0) {
            switch self.type {
            case .text:
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            case .secure:
                SecureField(placeholder, text: $text)
            }
            content
        }
    }
    
}

extension TextFieldView where Content == EmptyView {
    init(text: Binding<String>, title: String, placeholder: String, type: FieldType) {
        self.init(text: text, title: title, placeholder: placeholder, type: type, content: { EmptyView() })
    }
}
