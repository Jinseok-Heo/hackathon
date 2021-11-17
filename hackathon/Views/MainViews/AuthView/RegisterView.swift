//
//  RegisterView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .foregroundColor(.black)
            .background(Color.gray.opacity(0.4))
    }
    
}

struct SecureFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.black)
            .background(Color.gray.opacity(0.4))
    }
    
}

struct RegisterView: View {
    
    @StateObject
    var authVM: AuthViewModel = AuthViewModel()
    
    @State
    var email: String = ""
    @State
    var password: String = ""
    @State
    var verifiedPassword: String = ""
    @State
    var userName: String = ""
    @State
    var nickName: String = ""
    @State
    var gender: String = ""
    @State
    var birth: String = ""
    @State
    var company: String = ""
    @State
    var job: String = ""
    @State
    var year: String = ""
    @State
    var school: String = ""
    @State
    var major: String = ""
    @State
    var alertPresented: Bool = false
    
    let textFieldMF: TextFieldModifier = TextFieldModifier()
    let secureFieldMF: SecureFieldModifier = SecureFieldModifier()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    TextField("이메일을 입력하세요.", text: $email)
                        .modifier(textFieldMF)
                    TextField("아이디를 입력하세요.", text: $userName)
                        .modifier(textFieldMF)
                    SecureField("비밀번호를 입력하세요", text: $password)
                        .modifier(secureFieldMF)
                    SecureField("비밀번호를 다시 입력하세요", text: $verifiedPassword)
                        .modifier(secureFieldMF)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder()
                )
                
                VStack {
                    TextField("닉네임을 입력하세요.", text: $nickName)
                        .modifier(textFieldMF)
                    TextField("생년월일을 입력하세요.", text: $birth)
                        .modifier(textFieldMF)
                    TextField("학교를 입력하세요.", text: $school)
                        .modifier(textFieldMF)
                    TextField("전공을 입력하세요.", text: $major)
                        .modifier(textFieldMF)
                    Picker(selection: $gender) {
                        Text("남자").tag(0)
                        Text("여자").tag(1)
                    } label: {
                        HStack {
                            Text("성별:")
                            Text(gender)
                        }
                        .font(.system(size: 20))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder()
                )
                
                VStack {
                    TextField("회사를 입력하세요.", text: $company)
                        .modifier(textFieldMF)
                    TextField("직무를 입력하세요.", text: $job)
                        .modifier(textFieldMF)
                    TextField("연차를 입력하세요.", text: $year)
                        .modifier(textFieldMF)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder()
                )
                
                HStack {
                    Spacer()
                    Button {
                        tryRegister()
                    } label: {
                        Text("회원가입")
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color("secondColor"))
                            )
                    }
                    .alert(isPresented: $alertPresented) {
                        Alert(title: Text("회원가입 실패"), dismissButton: .default(Text("확인")))
                    }
                }
            }
            .padding()
        }
    }
    
}

extension RegisterView {
    
    private func tryRegister() {
        
        var genderEng: String = ""
        
        if password != verifiedPassword {
            alertPresented = true
            return
        }
        guard email != "" else {
            alertPresented = true
            return
        }
        guard verifiedPassword != "" else {
            alertPresented = true
            return
        }
        guard userName != "" else {
            alertPresented = true
            return
        }
        guard nickName != "" else {
            alertPresented = true
            return
        }
        guard birth != "" else {
            alertPresented = true
            return
        }
        guard gender != "" else {
            alertPresented = true
            return
        }
        guard school != "" else {
            alertPresented = true
            return
        }
        guard major != "" else {
            alertPresented = true
            return
        }
        guard company != "" else {
            alertPresented = true
            return
        }
        guard job != "" else {
            alertPresented = true
            return
        }
        guard year != "" else {
            alertPresented = true
            return
        }
        guard let yearInt = Int(year) else {
            alertPresented = true
            return
        }
        
        if gender == "남자" {
            genderEng = "male"
        } else {
            genderEng = "female"
        }
        
        authVM.tryRegister(email: email, password: password, userName: userName, nickName: nickName, gender: genderEng, birth: birth, company: company, job: job, year: yearInt, school: school, major: major)
    }
    
}
