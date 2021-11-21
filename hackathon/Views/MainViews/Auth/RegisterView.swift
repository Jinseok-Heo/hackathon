//
//  RegisterView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject
    var registerVM: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundView
            VStack(alignment: .leading) {
                NavigationLink(destination: HomeView(), isActive: $registerVM.registerCompleted) { EmptyView() }
                TabView(selection: $registerVM.pageState) {
                    basicView
                        .tag(0)
                    additionalView
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.top, 112)
                button
            }
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 22)
        .edgesIgnoringSafeArea(.top)
        
    }
    
    private var backgroundView: some View {
        VStack(alignment: .leading) {
            Text("회원가입")
                .font(FontManager.font(size: 26, weight: .bold))
                .foregroundColor(Color(hex: "#CECECE"))
                .padding(.top, 62)
            Spacer()
        }
    }
    
    private var basicView: some View {
        VStack(alignment: .leading, spacing: 44) {
            HStack(spacing: 36) {
                TextFieldView(text: $registerVM.nickName, title: "이름", placeholder: "이름", type: .text)
                    .frame(width: 156)
                genderSelection
            }
            TextFieldView(text: $registerVM.userName, title: "아이디", placeholder: "이메일을 입력해 주세요", type: .text)
                .padding(.bottom, 10)
            TextFieldView(text: $registerVM.password, title: "비밀번호", placeholder: "비밀번호를 입력해 주세요", type: registerVM.showPassword ? .text : .secure) {
                Button {
                    registerVM.showPassword.toggle()
                } label: {
                    Image(systemName: registerVM.showPassword ? "eye.slash" : "eye")
                        .resizable()
                        .frame(width: 24, height: 18)
                        .foregroundColor(Color(hex: "#C5C5C5"))
                }
            }
            Spacer()
        }
    }
    
    private var additionalView: some View {
        VStack(alignment: .leading, spacing: 54) {
            schoolField
            majorField
            Spacer()
        }
        .padding(.top, 125)
    }
    
    private var schoolField: some View {
        VStack(spacing: 0) {
            AdvancedTextFieldView(text: $registerVM.school,
                                  title: "대학교",
                                  placeholder: "대학교를 입력해주세요",
                                  isFocused: registerVM.isSchoolListPresented,
                                  content: EmptyView()) { isChanged in
                if isChanged {
                    self.registerVM.isSchoolListPresented = true
                }
            }
            if registerVM.isSchoolListPresented && registerVM.schoolList.count > 0 {
                List {
                    ForEach(registerVM.schoolList, id: \.self) { school in
                        Button {
                            registerVM.school = school
                            hideKeyboard()
                            registerVM.isSchoolListPresented = false
                        } label: {
                            HStack {
                                Text(school)
                                    .font(FontManager.font(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        }
                        .listRowBackground(Color(hex: "#F6F6F6"))
                        .frame(height: 40)
                    }
                }
                .listStyle(.plain)
                .frame(height: 120)
            }
        }
    }
    
    private var majorField: some View {
        VStack(spacing: 0) {
            AdvancedTextFieldView(text: $registerVM.major,
                                  title: "전공",
                                  placeholder: "전공을 입력해주세요",
                                  isFocused: registerVM.isMajorListPresented,
                                  content: {
                Button {
                    self.registerVM.major = ""
                    hideKeyboard()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(hex: "#555555"))
                }
            }) { isChanged in
                if isChanged {
                    if self.registerVM.isSchoolValidate() {
                        self.registerVM.isMajorListPresented = true
                    } else {
                        self.registerVM.generateAlert(message: "전공 먼저 선택해주세요")
                        hideKeyboard()
                    }
                }
            }
            if registerVM.isMajorListPresented && registerVM.majorList.count > 0 {
                List {
                    ForEach(registerVM.majorList, id: \.self) { major in
                        Button {
                            registerVM.major = major
                            hideKeyboard()
                            registerVM.isMajorListPresented = false
                        } label: {
                            HStack {
                                Text(major)
                                    .font(FontManager.font(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        }
                        .listRowBackground(Color(hex: "#F6F6F6"))
                        .frame(height: 40)
                    }
                }
                .listStyle(.plain)
                .frame(height: 120)
            }
        }
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
                    .foregroundColor(registerVM.gender == 1 ? .black : Color(hex: "#E3E3E3"))
                    .onTapGesture {
                        registerVM.gender = 1
                    }
                Text("남자")
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(registerVM.gender == 2 ? .black : Color(hex: "#E3E3E3"))
                    .onTapGesture {
                        registerVM.gender = 2
                    }
                Text("여자")
            }
            .font(FontManager.font(size: 15, weight: .semibold))
        }
    }
    
    private var button: some View {
        Button {
            registerVM.buttonHandler()
        } label: {
            Text(registerVM.pageState == 0 ? "다음" : "가입완료!")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "#C5C5C5")))
        }
        .alert(isPresented: $registerVM.showAlert) {
            Alert(title: Text("회원가입 실패"), message: Text(registerVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
    
}