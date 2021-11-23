//
//  AdditionalInfoView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI

struct AdditionalInfoView: View {
    
    @StateObject
    var additionalInfoVM: AdditionalInfoViewModel
    
    public init(userName: String, nickName: String, password: String, gender: Int, birth: String) {
        self._additionalInfoVM = StateObject(wrappedValue: AdditionalInfoViewModel(userName: userName, nickName: nickName, password: password, gender: gender, birth: birth))
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 39) {
                    titleView
                        .padding(.top, 62)
                    schoolField
                        .padding(.bottom, 15)
                    majorField
                    Spacer()
                    button
                }
                .opacity(additionalInfoVM.isLoading ? 0.3 : 1)
                .padding(.top, 63)
                if additionalInfoVM.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(.circular)
                }
            }
        }
        .padding([.leading, .trailing], 22)
        .navigationBarHidden(true)
    }
    
}

extension AdditionalInfoView {
    
    private var titleView: some View {
        Text("회원가입")
            .font(FontManager.font(size: 26, weight: .bold))
            .foregroundColor(Color(hex: "#CECECE"))
    }
    
    private var schoolField: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: ProfileView(), isActive: $additionalInfoVM.registerCompleted) { EmptyView() }
            AdvancedTextFieldView(text: $additionalInfoVM.school,
                                  title: "대학교",
                                  placeholder: "대학교를 입력해주세요",
                                  isFocused: additionalInfoVM.isSchoolListPresented,
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
            AdvancedTextFieldView(text: $additionalInfoVM.major,
                                  title: "전공",
                                  placeholder: "전공을 입력해주세요",
                                  isFocused: additionalInfoVM.isMajorListPresented,
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
                .frame(height: 120)
            }
        }
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
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "#C5C5C5")))
        }
        .alert(isPresented: $additionalInfoVM.showAlert) {
            Alert(title: Text("가입 실패"), message: Text(additionalInfoVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
    
}
