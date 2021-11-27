//
//  RoomView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import SwiftUI

class RoomViewModel: ObservableObject {
    
    @Published
    var chatMsg: String
    @Published
    var toAppointment: Bool
    
    init(mento: Mento?) {
        self.chatMsg = ""
        self.toAppointment = false
    }
    
}

struct RoomView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var roomVM: RoomViewModel
    
    let mento: Mento?
    
    init(mento: Mento?) {
        self.mento = mento
        self._roomVM = StateObject(wrappedValue: RoomViewModel(mento: mento))
    }
    
    var body: some View {
        VStack {
            if let mento = mento {
                NavigationLink(destination: MakeAppointmentView(mento: mento), isActive: $roomVM.toAppointment) { EmptyView() }
            }
            titleView
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
}


extension RoomView {
    
    @ViewBuilder private var titleView: some View {
        if let mento = mento {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 10, height: 17)
                            .foregroundColor(Color(hex: "#191919"))
                    }
                    .padding(.trailing, 16)
                    Text(mento.nickName)
                        .font(FontManager.font(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "#191919"))
                    Spacer()
                    Image(uiImage: mento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .padding(.trailing, 22)
                    Menu {
                        Button {
                            roomVM.toAppointment = true
                        } label: {
                            Text("약속 정하기")
                                .foregroundColor(Color(hex: "191919"))
                                .font(FontManager.font(size: 17, weight: .semibold))
                        }
                        .frame(width: 80)
                    } label: {
                        Image(systemName: "ellipsis.vertical.bubble")
                            .resizable()
                            .frame(width: 22, height: 24)
                            .foregroundColor(Color(hex: "#2E3A59"))
                    }
                }
                .padding(.leading, 22)
                .padding(.trailing, 23)
                .frame(height: 62)
                divider
                Spacer()
                bottomBar
            }
        }
    }
    
    private var bottomBar: some View {
        
        VStack(spacing: 0) {
            divider
            HStack(spacing: 0) {
                Image(systemName: "plus.square")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color(hex: "#767676"))
                    .padding(.leading, 25)
                TextField("메세지를 입력하세요", text: $roomVM.chatMsg)
                    .padding(.leading, 10)
                Spacer()
                Button {
                    // Do something
                } label: {
                    Circle()
                        .foregroundColor(Color("secondColor"))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: "arrowtriangle.forward")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#09121F"))
                        )
                        .padding(.trailing, 12)
                }
                
            }
            .frame(height: 60)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var divider: some View {
        Rectangle().frame(height: 2)
            .foregroundColor(Color(hex: "#FFF3CA"))
    }
    
}
