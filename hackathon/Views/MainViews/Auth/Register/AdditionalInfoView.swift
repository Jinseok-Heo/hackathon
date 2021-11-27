//
//  AdditionalInfoView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI

struct AdditionalInfoView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var additionalInfoVM: AdditionalInfoViewModel
    
    public init(userName: String, nickName: String, password: String, gender: Int, birth: String) {
        self._additionalInfoVM = StateObject(wrappedValue: AdditionalInfoViewModel(userName: userName, nickName: nickName, password: password, gender: gender, birth: birth))
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 10, height: 17)
                        Text("기본 정보")
                            .font(FontManager.font(size: 15, weight: .medium))
                            .offset(y: 1)
                    }
                    .foregroundColor(Color(hex: "#191919"))
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 26) {
                        titleView
                            .padding(.top, 40)
                        VStack(alignment: .leading, spacing: 54) {
                            schoolField
                            majorField
                            if !additionalInfoVM.isStudent {
                                VStack(alignment: .leading, spacing: 54) {
                                    companyField
                                    jobField
                                    yearField
                                }
                            }
                            HStack(spacing: 14) {
                                Text(additionalInfoVM.isStudent ? "직장인이신가요?" : "학생이신가요?")
                                Button {
                                    withAnimation {
                                        self.additionalInfoVM.isStudent.toggle()
                                    }
                                } label: {
                                    Image(systemName: additionalInfoVM.isStudent ? "checkmark.circle" : "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .foregroundColor(Color(hex: "#555555"))
                        }
                    }
                }
                Spacer()
                button
            }
            .opacity(additionalInfoVM.isLoading ? 0.3 : 1)
            if additionalInfoVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .alert(isPresented: $additionalInfoVM.showAlert) {
            Alert(title: Text("가입 실패"), message: Text(additionalInfoVM.alertMsg), dismissButton: .default(Text("확인")))
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 22)
    }
    
}

extension AdditionalInfoView {
    
    private var titleView: some View {
        Text("회원가입")
            .font(FontManager.font(size: 26, weight: .bold))
            .foregroundColor(Color(hex: "#000000"))
    }
    
    private var schoolField: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: ProfileView(), isActive: $additionalInfoVM.registerCompleted) { EmptyView() }
            AdvancedTextFieldView(text: $additionalInfoVM.school,
                                  title: "대학교",
                                  placeholder: "대학교를 입력해주세요",
                                  content: EmptyView()) { isChanged in
                if isChanged {
                    self.additionalInfoVM.isSchoolListPresented = true
                }
            }
            if additionalInfoVM.isSchoolListPresented && additionalInfoVM.schoolList.count > 0 {
                List {
                    ForEach(additionalInfoVM.schoolList, id: \.self) { school in
                        Button {
                            additionalInfoVM.school = school
                            hideKeyboard()
                            additionalInfoVM.isSchoolListPresented = false
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
                        .frame(height: 30)
                    }
                }
                .listStyle(.plain)
                .frame(height: 122)
            }
        }
    }
    
    private var majorField: some View {
        VStack(spacing: 0) {
            AdvancedTextFieldView(text: $additionalInfoVM.major,
                                  title: "전공",
                                  placeholder: "전공을 입력해주세요",
                                  content: {
                Button {
                    self.additionalInfoVM.major = ""
                    hideKeyboard()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color(hex: "#555555"))
                }
            }) { isChanged in
                if isChanged {
                    if self.additionalInfoVM.isSchoolValidate() {
                        self.additionalInfoVM.isMajorListPresented = true
                    } else {
                        self.additionalInfoVM.generateAlert(message: "전공 먼저 선택해주세요")
                        hideKeyboard()
                    }
                }
            }
            if additionalInfoVM.isMajorListPresented && additionalInfoVM.majorList.count > 0 {
                List {
                    ForEach(additionalInfoVM.majorList, id: \.self) { major in
                        Button {
                            additionalInfoVM.major = major
                            hideKeyboard()
                            additionalInfoVM.isMajorListPresented = false
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
                        .frame(height: 30)
                    }
                }
                .listStyle(.plain)
                .frame(height: 122)
            }
        }
    }
    
    private var companyField: some View {
        TextFieldView(text: $additionalInfoVM.company, title: "회사", placeholder: "회사를 입력해주세요", type: .text)
    }
    
    private var jobField: some View {
        TextFieldView(text: $additionalInfoVM.job, title: "직무", placeholder: "직무를 입력해주세요", type: .text)
    }
    
    private var yearField: some View {
        TextFieldView(text: $additionalInfoVM.year, title: "연차", placeholder: "연차를 입력해주세요", type: .text, keyboardType: .numberPad)
    }
    
    private var button: some View {
        Button {
            additionalInfoVM.register()
        } label: {
            Text("가입완료!")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("secondColor")))
        }
    }
    
}
