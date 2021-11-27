//
//  MentoAuthView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/24.
//

import SwiftUI
import Alamofire
import Kingfisher

struct MentoAuthView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var mentoAuthVM: MentoAuthViewModel = MentoAuthViewModel()
    
    var body: some View {
        ZStack {
            NavigationLink(destination: MyTabView(), isActive: $mentoAuthVM.didSuccess) { EmptyView() }
            VStack(alignment: .leading, spacing: 0) {
                backButton
                titleView
                    .padding(.top, 40)
                    .padding(.bottom, 26)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        emailField
                        emailAuthField
                        if mentoAuthVM.didAuthSuccess {
                            authHelperText
                        }
                        Spacer()
                        Text("나의 멘토링을 소개해주세요")
                            .font(FontManager.font(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#191919"))
                        untactSelection
                        localSelection
                        contentField
                    }
                }
                .frame(maxHeight: .infinity)
                Spacer()
                registerButton
                    .padding(.bottom)
            }
            if mentoAuthVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .alert(isPresented: $mentoAuthVM.showAlert) {
            Alert(title: Text("오류 발생"), message: Text(mentoAuthVM.alertMsg), dismissButton: .default(Text("확인")))
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 22)
    }
    
}

extension MentoAuthView {
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 17)
                Text("뒤로가기")
                    .font(FontManager.font(size: 15, weight: .medium))
                    .offset(y: 1)
            }
            .foregroundColor(Color(hex: "#191919"))
        }
    }
    
    private var titleView: some View {
        Text("멘토 등록하기")
            .font(FontManager.font(size: 26, weight: .bold))
            .foregroundColor(Color(hex: "#191919"))
    }
    
    private var registerButton: some View {
        Button {
            mentoAuthVM.register()
        } label: {
            Text("등록하기")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("secondColor")))
        }
    }
    
    private var emailField: some View {
        HStack(spacing: 6) {
            TextFieldView(text: $mentoAuthVM.email, title: "이메일", placeholder: "인증할 이메일을 입력해주세요", type: .text)
            Button {
                mentoAuthVM.emailAuthenticate()
            } label: {
                Text("인증하기")
                    .font(FontManager.font(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 8)
                    .padding([.top, .bottom], 8)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("secondColor")))
            }
        }
    }
    
    @ViewBuilder private var emailAuthField: some View {
        if mentoAuthVM.showEmailAuth {
            HStack {
                TextField("인증코드를 입력해주세요", text: $mentoAuthVM.authCode)
                    .keyboardType(.numberPad)
                    .font(FontManager.font(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#191919"))
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "#CECECE").opacity(0.3)))
                Button {
                    mentoAuthVM.submitPasscode()
                } label: {
                    Text("확인")
                        .font(FontManager.font(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 4)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("secondColor")))
                }
            }
        }
    }
    
    private var authHelperText: some View {
        Text("이메일 인증 완료 ✅")
            .font(FontManager.font(size: 13, weight: .semibold))
            .foregroundColor(Color(hex: "#191919"))
    }
    
    private var untactSelection: some View {
        HStack {
            Text("대면 여부")
                .font(FontManager.font(size: 17, weight: .medium))
            HStack(spacing: 6) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text("대면")
            }
            .scaleEffect(mentoAuthVM.untact == 1 ? 1.05 : 1)
            .padding()
            .foregroundColor(mentoAuthVM.untact == 1 ? Color(hex: "#555555") : Color(hex: "#E3E3E3"))
            .onTapGesture {
                withAnimation {
                    mentoAuthVM.untact = 1
                }
            }
            HStack(spacing: 6) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text("비대면")
            }
            .scaleEffect(mentoAuthVM.untact == 2 ? 1.05 : 1)
            .padding()
            .foregroundColor(mentoAuthVM.untact == 2 ? Color(hex: "#555555") : Color(hex: "#E3E3E3"))
            .onTapGesture {
                withAnimation {
                    mentoAuthVM.untact = 2
                }
            }
            Spacer()
        }
    }
    
    private var localSelection: some View {
        HStack {
            Text("활동 지역 선택")
                .font(FontManager.font(size: 17, weight: .medium))
                .padding(.trailing)
            Picker(selection: $mentoAuthVM.selectedProvince) {
                ForEach(DummyData.provinceList, id: \.self) { province in
                    Text(province)
                        .foregroundColor(Color(hex: "#191919"))
                        .tag(province)
                }
            } label: {
                Text("\(mentoAuthVM.selectedProvince)")
                    .foregroundColor(Color(hex: "#191919"))
            }
            .foregroundColor(Color(hex: "#191919"))
            .font(FontManager.font(size: 17, weight: .bold))
            .padding([.leading, .trailing], 8)
            .padding([.top, .bottom], 4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color("secondColor"))
            )
            Picker(selection: $mentoAuthVM.selectedCity) {
                ForEach(mentoAuthVM.cities, id: \.self) { city in
                    Text(city)
                        .tag(city)
                }
            } label: {
                Text("\(mentoAuthVM.selectedCity)")
            }
            .foregroundColor(Color(hex: "#191919"))
            .font(FontManager.font(size: 17, weight: .bold))
            .padding([.leading, .trailing], 8)
            .padding([.top, .bottom], 4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color("secondColor"))
            )
        }
    }
    
    private var contentField: some View {
        VStack(alignment: .leading) {
            Text("소개글")
                .font(FontManager.font(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "#777777"))
            TextEditor(text: $mentoAuthVM.content)
                .font(FontManager.font(size: 15, weight: .regular))
                .disableAutocorrection(true)
                .cornerRadius(4)
                .colorMultiply(Color(hex: "#ECECEC"))
                .frame(minHeight: 250)
        }
    }
    
}
