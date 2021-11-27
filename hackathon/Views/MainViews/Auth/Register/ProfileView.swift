//
//  ProfileView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @StateObject
    var profileVM: ProfileViewModel = ProfileViewModel()
    
    @State
    var pickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: MyTabView(), isActive: $profileVM.didSuccess) { EmptyView() }
            VStack {
                titleView
                    .padding(.top, 62)
                    .padding(.bottom, 30)
                profileImage
                Spacer()
                saveButton
                skipButton
            }
            .opacity(profileVM.isLoading ? 0.3 : 1)
            if profileVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .padding([.leading, .trailing], 22)
        .navigationBarHidden(true)
        .sheet(isPresented: $pickerPresented) {
            ImagePicker(selectedImage: $profileVM.image)
        }
        .alert(isPresented: $profileVM.isFailed) {
            Alert(title: Text("이미지 업로드 실패"), message: Text("네트워크 연결을 확인해주세요"), dismissButton: .default(Text("확인")))
        }
    }
    
}

extension ProfileView {
    
    private var titleView: some View {
        Text("프로필 이미지를 선택해주세요")
            .font(FontManager.font(size: 24, weight: .bold))
            .foregroundColor(Color(hex: "#191919"))
    }
    
    private var profileImage: some View {
        VStack(spacing: 20) {
            
            if let image = profileVM.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(Color(hex: "#555555"))
                    .shadow(color: Color(hex: "#555555").opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: Color(hex: "#555555").opacity(0.3), radius: 5, x: -5, y: -5)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(hex: "#555555"))
            }
            Text("탭해서 사진 바꾸기")
                .font(FontManager.font(size: 20, weight: .semibold))
                .foregroundColor(Color(hex: "#191919"))
        }
        .onTapGesture {
            pickerPresented = true
        }
    }
    
    private var saveButton: some View {
        Button {
            profileVM.upload()
        } label: {
            Text("저장")
                .font(FontManager.font(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("secondColor"))
                )
        }
    }
    
    private var skipButton: some View {
        Button {
            profileVM.uploadDefault()
        } label: {
            Text("건너뛰기")
                .font(FontManager.font(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("secondColor"))
                )
        }
    }
    
}
