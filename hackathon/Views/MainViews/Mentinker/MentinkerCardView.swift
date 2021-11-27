//
//  MentinkerCardView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import SwiftUI

struct MentinkCardView: View {
    
    @ObservedObject
    var mentinkerVM: MentinkerViewModel
    
    let mento: Mento
    var animation: Namespace.ID
    
    init(mento: Mento, vm: MentinkerViewModel, animation: Namespace.ID) {
        self.mento = mento
        self.mentinkerVM = vm
        self.animation = animation
    }
    
    var body: some View {
        ZStack {
            backgroundView
            HStack {
                profileView
                    .padding(.top, 14)
                VStack(alignment: .leading) {
                    basicInfoField
                    Spacer()
                }
                .padding(.top, 32)
            }
            .padding([.leading, .trailing], 14)
            untactImage
        }
        .frame(height: 140)
    }
    
}

extension MentinkCardView {
    
    @ViewBuilder private var backgroundView: some View {
        if mentinkerVM.showDetail {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color("secondColor").opacity(0.4))
        } else {
            RoundedRectangle(cornerRadius: 4)
                .matchedGeometryEffect(id: mento.id, in: animation)
                .foregroundColor(Color("secondColor").opacity(0.4))
        }
    }
    
    private var profileView: some View {
        VStack {
            Image(uiImage: mento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                .resizable()
                .frame(width: 65, height: 65)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
            ratingField
            Spacer()
        }
        .frame(width: 80, alignment: .leading)
    }
    
    private var basicInfoField: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(mento.nickName)
                    .foregroundColor(Color(hex: "#555555"))
                    .font(FontManager.font(size: 17, weight: .bold))
                Spacer()
            }
            Text(mento.preferredLocation)
                .foregroundColor(Color(hex: "#999999"))
                .font(FontManager.font(size: 15, weight: .medium))
                .padding(.bottom, 14)
            content
            Spacer()
        }
    }
    
    private var ratingField: some View {
        HStack(spacing: 0) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(Color("mainColor"))
            Text(mento.rating)
                .foregroundColor(.black)
                .font(FontManager.font(size: 14, weight: .semibold))
                .offset(y: 1.5)
        }
    }
    
    private var content: some View {
        Text(mento.content)
            .font(FontManager.font(size: 13, weight: .medium))
            .foregroundColor(Color(hex: "#191919"))
    }
    
    @ViewBuilder private var untactImage: some View {
        if mento.untact == "true" {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "video.fill")
                        .resizable()
                        .frame(width: 28, height: 17)
                        .padding(10)
                        .foregroundColor(Color(hex: "#CECECE"))
                }
                Spacer()
            }
        }
    }
    
}
