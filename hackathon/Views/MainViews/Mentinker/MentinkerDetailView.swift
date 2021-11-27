//
//  MentinkerDetailView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import SwiftUI

struct MentinkDetailView: View {
    
    @ObservedObject
    var mentinkerVM: MentinkerViewModel
    
    var animation: Namespace.ID
    
    init(vm: MentinkerViewModel, animation: Namespace.ID) {
        self.mentinkerVM = vm
        self.animation = animation
    }
    
    var body: some View {
        ZStack {
            backgroundView
            VStack(spacing: 0) {
                cancelButton
                    .padding()
                content
                    .padding(.top, 60)
                connectButton
                    .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
    }
    
}

extension MentinkDetailView {
    
    @ViewBuilder private var backgroundView: some View {
        if let selectedMento = mentinkerVM.selectedItem {
            RoundedRectangle(cornerRadius: 10)
                .matchedGeometryEffect(id: selectedMento.id, in: animation)
                .foregroundColor(Color(hex: "#F8F8FA"))
        } else {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(hex: "#F8F8FA"))
        }
    }
    
    private var cancelButton: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    self.mentinkerVM.showDetail = false
                    self.mentinkerVM.selectedItem = nil
                }
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.red)
            }
            Spacer()
        }
    }
    
    @ViewBuilder private var content: some View {
        if let selectedMento = self.mentinkerVM.selectedItem {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(uiImage: selectedMento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                    reviewField
                    HStack {
                        Text(selectedMento.nickName)
                            .font(FontManager.font(size: 26, weight: .bold))
                            .foregroundColor(Color(hex: "#191919"))
                            .padding(.bottom, 2)
                        ratingField
                    }
                    Text(selectedMento.preferredLocation)
                        .font(FontManager.font(size: 17, weight: .medium))
                        .foregroundColor(Color(hex: "#555555"))
                        .padding(.bottom, 20)
                    Text(selectedMento.content)
                        .font(FontManager.font(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#555555"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
    
    private var ratingField: some View {
        HStack(spacing: 0) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(Color("mainColor"))
            Text(mentinkerVM.selectedItem?.rating ?? "0.0")
                .foregroundColor(.black)
                .font(FontManager.font(size: 14, weight: .semibold))
                .offset(y: 1.5)
        }
    }
    
    private var connectButton: some View {
        Button {
            mentinkerVM.action = 1
        } label: {
            Text("연락하기")
                .font(FontManager.font(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 120)
                .padding([.top, .bottom], 10)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("secondColor")))
        }
    }
    
    private var reviewField: some View {
        Button {
            mentinkerVM.action = 2
        } label: {
            HStack {
                Spacer()
                Text("리뷰 보기")
                    .font(FontManager.font(size: 17, weight: .semibold))
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 17)
            }
            .foregroundColor(Color(hex: "#191919"))
        }
        .padding(.trailing, 10)
    }
    
}
