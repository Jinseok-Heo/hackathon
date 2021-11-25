//
//  CommunityView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

class CommunityViewModel: ObservableObject {
    
    @Published
    var communitySelection: Int
    
    @Published
    var isLoading: Bool
    @Published
    var alertTitle: String
    @Published
    var alertMsg: String
    @Published
    var showAlert: Bool
    
    public init() {
        self.communitySelection = 0
        self.isLoading = false
        self.alertTitle = ""
        self.alertMsg = ""
        self.showAlert = false
    }
    
}

struct CommunityView: View {
    
    @StateObject
    var communityVM: CommunityViewModel = CommunityViewModel()
    
    private let communityMenu: [String] = ["취업정보", "대외활동정보", "만나자 게더링", "자유주제"]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                titleView
                selectionField
                VStack {
                    sortOptionField
                    Spacer()
                }
                .padding([.leading, .trailing], 22)
            }
            if communityVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $communityVM.showAlert) {
            Alert(title: Text(communityVM.alertTitle), message: Text(communityVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
}

extension CommunityView {
    
    private var titleView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 26) {
                Text("커뮤니티")
                    .font(FontManager.font(size: 20, weight: .bold))
                    .padding(.leading, 22)
                Spacer()
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 16, height: 20)
                Image("ellipsis")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .padding(.trailing, 32)
            .frame(height: 64)
            Rectangle().frame(height: 2)
                .foregroundColor(Color(hex: "#FFF3CA"))
        }
    }
    
    private var selectionField: some View {
        HStack {
            ForEach(0..<4) { idx in
                Text(communityMenu[idx])
                    .foregroundColor(Color(hex: communityVM.communitySelection == idx ? "#333333" : "#767676"))
                    .font(FontManager.font(size: 13, weight: communityVM.communitySelection == idx ? .bold : .semibold))
                    .padding([.top, .bottom], 6)
                    .padding([.trailing, .leading], 9)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(communityVM.communitySelection == idx ? Color("secondColor") : Color(hex: "#F1F1F5"))
                    )
                    .onTapGesture {
                        withAnimation {
                            communityVM.communitySelection = idx
                        }
                    }
            }
        }
        .padding([.top, .bottom], 16)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F8F8FA"))
    }
    
    private var sortOptionField: some View {
        HStack(spacing: 3) {
            Spacer()
            Button {
                // Sort option
            } label: {
                Text("최신순")
                    .font(FontManager.font(size: 13, weight: .medium))
            }

            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .frame(width: 18, height: 12)
        }
        .foregroundColor(Color(hex: "#767676"))
    }
    
    private var content: some View {
        VStack {
            // community card view
        }
    }
    
}
