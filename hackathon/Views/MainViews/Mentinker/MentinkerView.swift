//
//  MentinkerView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MentinkerView: View {
    
    @StateObject
    var mentinkerVM: MentinkerViewModel = MentinkerViewModel()
    
    @Namespace
    private var animation
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: RoomView(mento: mentinkerVM.selectedItem), tag: 1, selection: $mentinkerVM.action) { EmptyView() }
            NavigationLink(destination: ReviewDetailView(mento: mentinkerVM.selectedItem), tag: 2, selection: $mentinkerVM.action) { EmptyView() }
            VStack(spacing: 0) {
                titleView
                    .padding(.bottom, 16)
                sortOptionField
                    .padding([.leading, .trailing], 22)
                    .padding(.bottom, 20)
                content
                Spacer()
            }
            .opacity(mentinkerVM.selectedItem == nil ? 1 : 0.4)
            .zIndex(1)
            if mentinkerVM.showDetail {
                MentinkDetailView(vm: mentinkerVM, animation: animation)
                    .zIndex(2)
            }
            if mentinkerVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $mentinkerVM.showAlert) {
            Alert(title: Text(mentinkerVM.alertTitle), message: Text(mentinkerVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
    
}

extension MentinkerView {
    
    private var titleView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 26) {
                Text("멘팅커")
                    .font(FontManager.font(size: 26, weight: .bold))
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
    
    private var sortOptionField: some View {
        HStack(spacing: 3) {
            Spacer()
            Button {
                // Sort option
            } label: {
                Text("검색 옵션")
                    .font(FontManager.font(size: 13, weight: .medium))
            }
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .frame(width: 18, height: 12)
        }
        .foregroundColor(Color(hex: "#767676"))
    }
    
    private var content: some View {
        List(mentinkerVM.mentos) { mento in
            MentinkCardView(mento: mento, vm: mentinkerVM, animation: animation)
                .frame(height: 140)
                .onTapGesture {
                    withAnimation {
                        self.mentinkerVM.selectedItem = mento
                        self.mentinkerVM.showDetail = true
                    }
                }
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
    }
    
}
