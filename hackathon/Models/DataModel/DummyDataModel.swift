//
//  DummyDataModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

final class DummyData {
    
    static let users: [UserResponse] = [
        UserResponse(id: 0, name: "daram12", mailAddress: "daram12@khu.ac.kr", password: "1234", isVerified: false),
        UserResponse(id: 1, name: "ybk441", mailAddress: "ybk1234@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 2, name: "daisy", mailAddress: "daisy1234@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 3, name: "mike123", mailAddress: "mike123@khu.ac.kr", password: "1234", isVerified: true),
        UserResponse(id: 4, name: "rachel11", mailAddress: "rachel11@khu.ac.kr", password: "1234", isVerified: true)
    ]
    
    static let user: UserResponse = users.first!
    
    static let profiles: [ProfileResponse] = [
        ProfileResponse(id: 0, userId: 0, nickName: "다람이", imageId: 0, gender: "male", birth: Date(), company: "네이버", job: "iOS 개발", school: "경희대학교", major: "기계공학과"),
        ProfileResponse(id: 1, userId: 1, nickName: "ybk123", imageId: 0, gender: "female", birth: Date(), company: "카카오", job: "안드로이드 개발", school: "서울대학교", major: "컴퓨터공학과"),
        ProfileResponse(id: 2, userId: 2, nickName: "김지원", imageId: 0, gender: "female", birth: Date(), company: "구글", job: "소프트웨어 엔지니어", school: "고려대학교", major: "소프트웨어공학과"),
        ProfileResponse(id: 3, userId: 3, nickName: "시드니", imageId: 0, gender: "male", birth: Date(), company: "삼성", job: "소프트웨어 엔지니어", school: "건국대학교", major: "화학공학과"),
        ProfileResponse(id: 4, userId: 4, nickName: "데이지", imageId: 0, gender: "female", birth: Date(), company: "쿠팡", job: "백엔드 엔지니어", school: "경희대학교", major: "컴퓨터공학과")
    ]
    
    static let mentoes: [MentoResponse] = [
        MentoResponse(id: 0, userId: 1, isVerifed: true, years: 2),
        MentoResponse(id: 1, userId: 2, isVerifed: true, years: 3),
        MentoResponse(id: 2, userId: 3, isVerifed: true, years: 4),
        MentoResponse(id: 3, userId: 4, isVerifed: true, years: 3)
    ]
    
    static let matching: [MatchingResponse] = [
        MatchingResponse(id: 0, mentorId: 1, menteeId: 0, untact: true, time: DummyData.dates[0]),
        MatchingResponse(id: 1, mentorId: 2, menteeId: 0, untact: false, time: DummyData.dates[1]),
        MatchingResponse(id: 2, mentorId: 3, menteeId: 0, untact: true, time: DummyData.dates[2]),
        MatchingResponse(id: 3, mentorId: 1, menteeId: 4, untact: true, time: DummyData.dates[3]),
        MatchingResponse(id: 4, mentorId: 2, menteeId: 4, untact: false, time: DummyData.dates[4])
    ]
    
    static let location: [LocationResponse] = [
        LocationResponse(id: 0, userId: 0, latitude: 35, longitude: 127, local: "Seoul"),
        LocationResponse(id: 1, userId: 1, latitude: 35.5, longitude: 127.4, local: "Seoul"),
        LocationResponse(id: 2, userId: 2, latitude: 35.3, longitude: 127.3, local: "Seoul"),
        LocationResponse(id: 3, userId: 3, latitude: 35.2, longitude: 127.5, local: "Seoul"),
        LocationResponse(id: 4, userId: 4, latitude: 35.4, longitude: 127.1, local: "Seoul"),
    ]
    
    static let jobList: [String] = {
        if let path = Bundle.main.path(forResource: "JobList", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let list = data.components(separatedBy: .newlines)
                return list
            } catch {
                print(error)
            }
        }
        return []
    }()
    
    static let schoolList: [String] = {
        if let path = Bundle.main.path(forResource: "SchoolList", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let list = data.components(separatedBy: .newlines)
                return list
            } catch {
                print(error)
            }
        }
        return []
    }()
    
    static let majorList: [String] = {
        if let path = Bundle.main.path(forResource: "MajorList", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let list = data.components(separatedBy: .newlines)
                return list
            } catch {
                print(error)
            }
        }
        return []
    }()
    
    static let promotion: [PromotionResponse] = [
        PromotionResponse(id: 0, mentoId: 1, title: "금융사 마케터 신입 지원 노하우 A to Z 코칭 원데이 클래스", description: "", price: 100, imageId: 0),
        PromotionResponse(id: 0, mentoId: 2, title: "금융 데이터 3년차의 엑셀 차트 시각화 멘토링", description: "", price: 100, imageId: 0),
        PromotionResponse(id: 0, mentoId: 3, title: "1 : 1 첨삭으로 자기소개서 합격을 위한 비결 대방출", description: "", price: 100, imageId: 0)
    ]
    
    static let images: [ImageResponse] = [
        ImageResponse(id: 0, fillSize: 10, name: "placeholder", path: "placeholder")
    ]

    static let hotCommunities: [BoardResponse] = [
        BoardResponse(id: 0, title: "올해 상반기 공채 준비중인데",
                      content: "이번 여름방학 때 레벨업 하려고 하는데 학원보다 인강 결제가 싼 것 같던데 가나다ㅏ라라라",
                      writerId: 0, createdDate: DummyData.dates[3], edited: false),
        BoardResponse(id: 1, title: "이력서에 사진이요",
                      content: "요즘 이력서에는 사진 잘 안붙이는 블라인드 채용이 많다고 하던데 맞나요ㅠㅠ",
                      writerId: 0, createdDate: DummyData.dates[4], edited: false),
        BoardResponse(id: 2, title: "여러분 토익점수 몇 나오세요?",
                      content: "재작년에 토익을 봤었는데 좀더 점수를 올리고 싶어서 공부하고 있는데 조언구해요",
                      writerId: 1, createdDate: DummyData.dates[5], edited: false)
        
    ]
    
    static let dates: [Date] = [
        Calendar.current.date(from: DummyData.dateComponents[0])!,
        Calendar.current.date(from: DummyData.dateComponents[1])!,
        Calendar.current.date(from: DummyData.dateComponents[2])!,
        Calendar.current.date(from: DummyData.dateComponents[3])!,
        Calendar.current.date(from: DummyData.dateComponents[4])!,
        Calendar.current.date(from: DummyData.dateComponents[5])!
    ]
    
    static let dateComponents: [DateComponents] = [
        DateComponents(year: 2021, month: 11, day: 23, hour: 4, minute: 20),
        DateComponents(year: 2021, month: 11, day: 29, hour: 3, minute: 00),
        DateComponents(year: 2021, month: 12, day: 1, hour: 2, minute: 40),
        DateComponents(year: 2021, month: 11, day: 22, hour: 6, minute: 15),
        DateComponents(year: 2021, month: 11, day: 22, hour: 5, minute: 39),
        DateComponents(year: 2021, month: 11, day: 18, hour: 4, minute: 20),
    ]
    
}
