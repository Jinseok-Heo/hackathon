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
    private var namespace
    
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
                VStack {
                    sortOptionField
                        .padding(.bottom, 20)
                    content
                    Spacer()
                }
                .padding([.leading, .trailing], 22)
            }
            .opacity(mentinkerVM.selectedItem == nil ? 1 : 0.4)
            if let selectedItem = mentinkerVM.selectedItem {
                MentinkDetailView(vm: mentinkerVM)
                    .matchedGeometryEffect(id: Int(selectedItem.id)!, in: namespace)
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

struct MentinkCardView: View {
    
    @ObservedObject
    var mentinkerVM: MentinkerViewModel
    
    let mento: Mento
    
    init(mento: Mento, vm: MentinkerViewModel) {
        self.mento = mento
        self.mentinkerVM = vm
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(mento.untact == "true" ? "mainColor" : "secondColor").opacity(0.4))
            HStack {
                Image(uiImage: mento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: mento.untact == "true" ? "person.crop.circle.fill.badge.xmark" : "person.crop.circle.fill.badge.checkmark")
                            .resizable()
                            .frame(width: 30, height: 25)
                            .foregroundColor(Color(hex: "#191919"))
                    }
                    .padding([.leading, .trailing], 14)
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text(mento.nickName)
                        .foregroundColor(Color(hex: "#555555"))
                        .font(FontManager.font(size: 20, weight: .bold))
                    Text(mento.preferredLocation)
                        .foregroundColor(Color(hex: "#999999"))
                        .font(FontManager.font(size: 15, weight: .medium))
                        .offset(x: 10)
                    Spacer()
                }
                .offset(y: 10)
                Spacer()
            }
        }
        .frame(height: 140)
    }
    
}

struct MentinkDetailView: View {
    
    @ObservedObject
    var mentinkerVM: MentinkerViewModel
    
    init(vm: MentinkerViewModel) {
        self.mentinkerVM = vm
    }
    
    var body: some View {
        ZStack {
            if let selectedMento = mentinkerVM.selectedItem {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(hex: "#F8F8FA"))
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            withAnimation(.easeInOut) {
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
                    .padding()
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Image(uiImage: selectedMento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                                .resizable()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .padding(.bottom, 20)
                            Text(selectedMento.nickName)
                                .font(FontManager.font(size: 26, weight: .bold))
                                .foregroundColor(Color(hex: "#191919"))
                                .padding(.bottom, 2)
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
                    .padding(.top, 60)
                    HStack {
                        Button {
                            mentinkerVM.action = 1
                        } label: {
                            Text("멘토링 요청")
                                .font(FontManager.font(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 120)
                                .padding([.top, .bottom], 10)
                                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("secondColor")))
                        }
                        Spacer()
                        Button {
                            mentinkerVM.action = 2
                        } label: {
                            Text("리뷰 보기")
                                .font(FontManager.font(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 120)
                                .padding([.top, .bottom], 10)
                                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("secondColor")))
                        }
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
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
        List {
            ForEach(mentinkerVM.mentos) { mento in
                MentinkCardView(mento: mento, vm: mentinkerVM)
                    .matchedGeometryEffect(id: Int(mento.id)!, in: namespace)
                    .foregroundColor(Color("mainColor"))
                    .frame(height: 140)
                    .onTapGesture {
                        withAnimation {
                            self.mentinkerVM.selectedItem = mento
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden, edges: .all)
                    
            }
        }
        .listStyle(.plain)
    }
    
}
