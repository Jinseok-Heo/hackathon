//
//  MentoAuthViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/24.
//

import SwiftUI
import Alamofire
import CoreLocation
import Combine

class MentoAuthViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
    @Published
    var email: String
    @Published
    var content: String
    @Published
    var preferredLocation: CLLocationCoordinate2D?
    @Published
    var untact: Int
    @Published
    var authCode: String
    @Published
    var didAuthSuccess: Bool
    @Published
    var selectedProvince: String
    @Published
    var selectedCity: String
    @Published
    var cities: [String]
    
    @Published
    var showEmailAuth: Bool
    @Published
    var isLoading: Bool
    @Published
    var didSuccess: Bool
    @Published
    var didFailed: Bool
    @Published
    var showAlert: Bool
    @Published
    var alertMsg: String
    
    var locationManager: CLLocationManager? = nil
    
    public override init() {
        self.email = ""
        self.content = ""
        self.selectedCity = ""
        self.cities = DataSet.locationList.first!.cities
        self.selectedProvince = DataSet.provinceList.first!
        self.preferredLocation = nil
        self.untact = 0
        
        self.didAuthSuccess = false
        self.authCode = ""
        self.showEmailAuth = false
        self.isLoading = false
        self.didSuccess = false
        self.didFailed = false
        self.showAlert = false
        self.alertMsg = ""
        
        super.init()
        
        checkLocationServiceEnabled()
        addLocalSubscriber()
    }
    
    private func addLocalSubscriber() {
        $selectedProvince
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .sink { province in
                self.cities = DataSet.locationList.filter { $0.province == province }.first?.cities ?? []
                self.selectedCity = self.cities.first!
            }
            .store(in: &cancellabels)
    }
    
    public func register() {
        if checkForm() {
            isLoading = true
            MentoAPIService.register(content: content,
                                     preferredLocation: "\(selectedProvince)/\(selectedCity)",
                                     untact: untact == 2,
                                     userId: SecurityManager.shared.load(account: .userID)!,
                                     completion: registerCompletionHandler)
        }
    }
    
    public func emailAuthenticate() {
        guard email != "" && checkEmail() else {
            generageAlert(message: "???????????? ???????????? ??????????????????.")
            return
        }
        isLoading = true
        MentoAPIService.sendEmail(email: email) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = true
                self.generageAlert(message: "??????????????? ?????????????????????.")
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.generageAlert(message: "????????? ?????? ??????")
            }
        }
    }
    
    public func submitPasscode() {
        isLoading = true
        MentoAPIService.authenticate(passcode: authCode) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = false
                self.didAuthSuccess = true
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    if statusCode >= 400 && statusCode < 500 {
                        self.generageAlert(message: "??????????????? ??????????????????")
                    } else {
                        self.generageAlert(message: "???????????? ????????? ??????????????????")
                    }
                } else {
                    self.generageAlert(message: "???????????? ????????? ??????????????????")
                }
                NSLog(error.localizedDescription)
            }
        }
    }
    
    private func checkEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func checkForm() -> Bool {
        guard didAuthSuccess else {
            generageAlert(message: "???????????? ??????????????????")
            return false
        }
        guard untact != 0 else {
            generageAlert(message: "??????/???????????? ??????????????????")
            return false
        }
        guard content != "" else {
            generageAlert(message: "???????????? ??????????????????")
            return false
        }
        guard preferredLocation != nil else {
            generageAlert(message: "??????????????? ????????? ??? ????????????")
            return false
        }
        return true
    }
    
    private func registerCompletionHandler(response: AFDataResponse<Any>) {
        isLoading = false
        switch response.result {
        case .success:
            didSuccess = true
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func generageAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
}

extension MentoAuthViewModel {
    
    private func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            generageAlert(message: "???????????? ???????????? ????????? ??? ????????????.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            generageAlert(message: "???????????? ???????????? ?????????????????????.")
        case .denied:
            generageAlert(message: "???????????? ???????????? ?????????????????????.")
        case .authorizedAlways, .authorizedWhenInUse:
            preferredLocation = locationManager.location?.coordinate
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
