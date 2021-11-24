//
//  CLLocationExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/24.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    func toDictionary() -> [String:Any] {
        let latitude = self.latitude
        let longitude = self.longitude
        let dict: [String:Any] = [
            "latitude": latitude,
            "longitude": longitude
        ]
        return dict
    }
    
}
