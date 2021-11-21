//
//  AdvancedTextFieldView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/21.
//

import SwiftUI

struct AdvancedTextFieldView<Content: View>: View {
    
    @Binding
    var text: String
    @FocusState
    var isFocused: Bool
    
    var title: String
    var placeholder: String
    let editHandler: (Bool) -> ()
    let content: Content
    
    init(text: Binding<String>,
         title: String,
         placeholder: String,
         isFocused: Bool,
         content: Content,
         editHandler: @escaping (Bool) -> ()) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.editHandler = editHandler
        self.content = content
        self.isFocused = isFocused
    }
    
    init(text: Binding<String>,
         title: String,
         placeholder: String,
         isFocused: Bool,
         @ViewBuilder content: () -> Content,
         editHandler: @escaping (Bool) -> ()) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.editHandler = editHandler
        self.content = content()
        self.isFocused = isFocused
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
            TextField(placeholder, text: $text, onEditingChanged: editHandler)
                .focused($isFocused)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            content
        }
    }
    
}
