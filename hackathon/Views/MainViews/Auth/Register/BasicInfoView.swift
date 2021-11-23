//
//  BasicInfoView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI

struct BasicInfoView: View {
    
    @StateObject
    var basicInfoVM: BasicInfoViewModel = BasicInfoViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            NavigationLink(
                destination: AdditionalInfoView(userName: basicInfoVM.userName,
                                                nickName: basicInfoVM.nickName,
                                                password: basicInfoVM.password,
                                                gender: basicInfoVM.gender,
                                                birth: basicInfoVM.birth),
                isActive: $basicInfoVM.submitSuccess) { EmptyView() }
            titleView
            HStack(spacing: 36) {
                nameField
                genderSelection
            }
            .padding(.bottom, 18)
            userNameField
                .padding(.bottom, 28)
            passwordField
                .padding(.bottom, 28)
            birthField
            Spacer()
            button
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 22)
    }
    
}

extension BasicInfoView {
    
    private var titleView: some View {
        Text("회원가입")
            .font(FontManager.font(size: 26, weight: .bold))
            .foregroundColor(Color(hex: "#CECECE"))
            .padding(.top, 62)
    }
    
    private var genderSelection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("성별")
                .font(FontManager.font(size: 15, weight: .extrabold))
                .foregroundColor(Color(hex: "#999999"))
            HStack(spacing: 6) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(basicInfoVM.gender == 1 ? .black : Color(hex: "#E3E3E3"))
                    .onTapGesture {
                        basicInfoVM.gender = 1
                    }
                Text("남자")
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(basicInfoVM.gender == 2 ? .black : Color(hex: "#E3E3E3"))
                    .onTapGesture {
                        basicInfoVM.gender = 2
                    }
                Text("여자")
            }
            .font(FontManager.font(size: 15, weight: .semibold))
        }
    }
    
    private var nameField: some View {
        TextFieldView(text: $basicInfoVM.nickName, title: "이름", placeholder: "이름", type: .text)
            .frame(width: 156)
    }
    
    private var userNameField: some View {
        TextFieldView(text: $basicInfoVM.userName, title: "아이디", placeholder: "이메일을 입력해 주세요", type: .text)
    }
    
    private var passwordField: some View {
        TextFieldView(text: $basicInfoVM.password, title: "비밀번호", placeholder: "비밀번호를 입력해 주세요", type: basicInfoVM.showPassword ? .text : .secure) {
            Button {
                basicInfoVM.showPassword.toggle()
            } label: {
                Image(systemName: basicInfoVM.showPassword ? "eye.slash" : "eye")
                    .resizable()
                    .frame(width: 24, height: 18)
                    .foregroundColor(Color(hex: "#C5C5C5"))
            }
        }
    }
    
    private var birthField: some View {
        TextFieldView(text: $basicInfoVM.birth, title: "생년월일", placeholder: "생년월일을 입력해 주세요", type: .text, keyboardType: .numberPad)
    }
    
    private var button: some View {
        Button {
            basicInfoVM.submitForm()
        } label: {
            Text("다음")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "#C5C5C5")))
        }
        .alert(isPresented: $basicInfoVM.showAlert) {
            Alert(title: Text("정보 미입력"), message: Text(basicInfoVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
    
}
