//
//  MakeAppointmentView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI
import Combine

class MakeAppointmentViewModel: ObservableObject {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
    @Published
    var selectedDate: Date
    @Published
    var selectedProvince: String
    @Published
    var selectedCity: String
    @Published
    var cities: [String]
    
    @Published
    var didSuccess: Bool
    
    let mento: Mento
    
    public init(mento: Mento) {
        self.selectedDate = Date()
        self.selectedCity = ""
        self.selectedProvince = DummyData.provinceList.first!
        self.cities = DummyData.localList.first!.cities
        self.mento = mento
        self.didSuccess = false
        addLocalSubscriber()
    }
    
    private func addLocalSubscriber() {
        $selectedProvince
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { province in
                self.cities = DummyData.localList.filter { $0.province == province }.first?.cities ?? []
                self.selectedCity = self.cities.first!
            }
            .store(in: &cancellabels)
    }
    
    public func save() {
        guard let menteeId = SecurityManager.shared.load(account: .userID) else { return }
        let location = selectedProvince == "선택안함" ? nil : String("\(selectedProvince) / \(selectedCity)")
        MatchingAPIService.matching(menteeId: menteeId,
                                    mentoId: mento.id,
                                    location: location, appointmentTime: selectedDate) { response in
            switch response.result {
            case .success:
                self.didSuccess = true
                print(response.response?.allHeaderFields)
            case .failure(let err):
                NSLog(err.localizedDescription)
            }
        }
    }
    
}

struct MakeAppointmentView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var makeAppointmentVM: MakeAppointmentViewModel
    
    let mento: Mento
    
    init(mento: Mento) {
        self._makeAppointmentVM = StateObject(wrappedValue: MakeAppointmentViewModel(mento: mento))
        self.mento = mento
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: CheckView(mento: mento), isActive: $makeAppointmentVM.didSuccess) { EmptyView() }
            titleView
                .padding(.bottom, 28)
            VStack(alignment: .leading) {
                Text("멘토링할 날짜 선택하기")
                    .font(FontManager.font(size: 24, weight: .bold))
                    .foregroundColor(Color(hex: "#191919"))
                DatePicker("날짜를 선택해주세요", selection: $makeAppointmentVM.selectedDate)
                    .datePickerStyle(.graphical)
                localSelection
                Spacer()
                saveButton
            }
            .padding([.leading, .trailing], 22)
        }
        .navigationBarHidden(true)
    }
    
}

extension MakeAppointmentView {
    
    private var titleView: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 17)
                    .foregroundColor(Color(hex: "#191919"))
            }
            .padding(.leading, 22)
            Text("돌아가기")
                .font(FontManager.font(size: 18, weight: .semibold))
                .foregroundColor(Color(hex: "#191919"))
            Spacer()
        }
    }
    
    private var localSelection: some View {
        VStack(alignment: .leading) {
            Text("멘토링할 지역을 선택해주세요")
                .font(FontManager.font(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#191919"))
            HStack {
                Picker(selection: $makeAppointmentVM.selectedProvince) {
                    ForEach(DummyData.provinceList, id: \.self) { province in
                        Text(province)
                            .foregroundColor(Color(hex: "#191919"))
                            .tag(province)
                    }
                } label: {
                    Text("\(makeAppointmentVM.selectedProvince)")
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
                Picker(selection: $makeAppointmentVM.selectedCity) {
                    ForEach(makeAppointmentVM.cities, id: \.self) { city in
                        Text(city)
                            .tag(city)
                    }
                } label: {
                    Text("\(makeAppointmentVM.selectedCity)")
                }
                .foregroundColor(Color(hex: "#191919"))
                .font(FontManager.font(size: 17, weight: .bold))
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color("secondColor"))
                )
                Spacer()
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            makeAppointmentVM.save()
        } label: {
            Text("멘토링 확정하기")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("secondColor")))
        }
    }
    
}
