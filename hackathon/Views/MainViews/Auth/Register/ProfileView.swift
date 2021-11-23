//
//  ProfileView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject
    var profileVM: ProfileViewModel = ProfileViewModel()
    
    @State
    var pickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: MyTabView(), isActive: $profileVM.didSuccess) { EmptyView() }
            VStack {
                Image(uiImage: profileVM.image)
                    .resizable()
                    .frame(width: 240, height: 240)
                    .clipShape(Circle())
                    .foregroundColor(Color(hex: "#555555"))
                    .padding(.bottom, 20)
                    .onTapGesture {
                        pickerPresented = true
                    }
                Button {
                    profileVM.upload()
                } label: {
                    Text("저장")
                        .font(FontManager.font(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "#999999"))
                        .frame(maxWidth: .infinity)
                        .padding([.top, .bottom], 8)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color("secondColor"))
                        )
                        .padding()
                }
            }
            .opacity(profileVM.isLoading ? 0.3 : 1)
            if profileVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $pickerPresented) {
            ImagePicker(selectedImage: $profileVM.image)
        }
        .alert(isPresented: $profileVM.isFailed) {
            Alert(title: Text("이미지 업로드 실패"), message: Text("네트워크 연결을 확인해주세요"), dismissButton: .default(Text("확인")))
        }
    }
    
}
