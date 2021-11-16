//
//  DummyDataModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

final class DummyData {
    
    static let users: [UserResponse] = [
        UserResponse(id: 0, name: "허진석", mailAddress: "hjs7747@khu.ac.kr", password: "1234", isVerified: false),
        UserResponse(id: 1, name: "김윤비", mailAddress: "ybk1234@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 2, name: "데이지", mailAddress: "daisy1234@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 3, name: "한수정", mailAddress: "crystal1234@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 4, name: "김경환", mailAddress: "khk1234@khu.ac.kr", password: "1234", isVerified: false)
    ]
    
    static let user: UserResponse = users.first!
    
    static let profiles: [ProfileResponse] = [
        ProfileResponse(id: 0, userId: 0, nickName: "jiheo", gender: "male", birth: Date(), company: "네이버", job: "iOS 개발", school: "경희대학교", major: "기계공학과"),
        ProfileResponse(id: 1, userId: 1, nickName: "ybk123", gender: "female", birth: Date(), company: "카카오", job: "안드로이드 개발", school: "서울대학교", major: "컴퓨터공학과"),
        ProfileResponse(id: 2, userId: 2, nickName: "daisy123", gender: "female", birth: Date(), company: "구글", job: "소프트웨어 엔지니어", school: "고려대학교", major: "소프트웨어공학과"),
        ProfileResponse(id: 3, userId: 3, nickName: "crystal", gender: "female", birth: Date(), company: "삼성", job: "소프트웨어 엔지니어", school: "건국대학교", major: "화학공학과"),
        ProfileResponse(id: 4, userId: 4, nickName: "khk123", gender: "male", birth: Date(), company: "쿠팡", job: "백엔드 엔지니어", school: "경희대학교", major: "컴퓨터공학과")
    ]
    
    static let mentoes: [MentoResponse] = [
        MentoResponse(id: 0, userId: 1, isVerifed: true),
        MentoResponse(id: 0, userId: 2, isVerifed: true),
        MentoResponse(id: 0, userId: 3, isVerifed: true)
    ]
    
    static let matching: [MatchingResponse] = [
        MatchingResponse(id: 0, mentorId: 1, menteeId: 0, untact: true, time: Date()),
        MatchingResponse(id: 1, mentorId: 2, menteeId: 0, untact: false, time: Date()),
        MatchingResponse(id: 2, mentorId: 3, menteeId: 0, untact: true, time: Date()),
        MatchingResponse(id: 3, mentorId: 1, menteeId: 4, untact: true, time: Date()),
        MatchingResponse(id: 4, mentorId: 2, menteeId: 4, untact: false, time: Date())
    ]
    
    static let location: [LocationResponse] = [
        LocationResponse(id: 0, userId: 0, latitude: 35, longitude: 127, local: "Seoul"),
        LocationResponse(id: 1, userId: 1, latitude: 35.5, longitude: 127.4, local: "Seoul"),
        LocationResponse(id: 2, userId: 2, latitude: 35.3, longitude: 127.3, local: "Seoul"),
        LocationResponse(id: 3, userId: 3, latitude: 35.2, longitude: 127.5, local: "Seoul"),
        LocationResponse(id: 4, userId: 4, latitude: 35.4, longitude: 127.1, local: "Seoul"),
    ]
    
    static let jobList: [String] = {
        let fileManager = FileManager()
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("FileManger Directory")
        
        do {
            let jobListPath = dataPath.appendingPathComponent("/Data/JobList.txt")
            let text = try String(contentsOf: jobListPath, encoding: .utf8)
            return text.split(separator: "\n") as? [String] ?? []
        } catch {
            print(error)
        }
        return []
    }()
    
    static let schoolList: [String] = {
        let fileManager = FileManager()
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("FileManger Directory")
        
        do {
            let schoolListPath = dataPath.appendingPathComponent("/Data/SchoolList.txt")
            let text = try String(contentsOf: schoolListPath, encoding: .utf8)
            return text.split(separator: "\n") as? [String] ?? []
        } catch {
            print(error)
        }
        return []
    }()
    
    static let majorList: [String] = {
        let fileManager = FileManager()
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("FileManger Directory")
        
        do {
            let majorListPath = dataPath.appendingPathComponent("/Data/SchoolList.txt")
            let text = try String(contentsOf: majorListPath, encoding: .utf8)
            return text.split(separator: "\n") as? [String] ?? []
        } catch {
            print(error)
        }
        return []
    }()
    
}
