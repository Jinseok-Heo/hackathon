//
//  MatchingRouter.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import Foundation
import Alamofire

enum MatchingRouter: URLRequestConvertible {
    
    case getList
    case matching(menteeId: String, mentoId: String, location: String?, appointmentTime: Date)
    case postReview(rating: Int, matchingId: String, mentoId: String, content: String)
    case getMentoReview(mentoId: String)

    var endPoint: String {
        switch self {
        case .getList:
            return "/app/mentolist"
        case .matching:
            return "/app/matching"
        case .postReview:
            return "/app/matching/review"
        case .getMentoReview(mentoId: let mentoId):
            return "/app/matching/review/\(mentoId)"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }

    var parameters: Parameters {
        switch self {
        case .getList, .getMentoReview:
            let params = Parameters()
            return params
        case let .matching(menteeId, mentoId, location, appointmentTime):
            var params = Parameters()
            params["menteeId"] = menteeId
            params["mentoId"] = mentoId
            params["location"] = location
            params["appointmentTime"] = appointmentTime.toString()
            return params
        case let .postReview(rating, matchingId, mentoId, content):
            var params = Parameters()
            params["rating"] = rating
            params["matchingId"] = matchingId
            params["mentoId"] = mentoId
            params["content"] = content
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = NetworkManager.base + endPoint
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedUrl)!
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        return request
    }

}


