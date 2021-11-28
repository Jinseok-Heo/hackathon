//
//  DummyDataModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

typealias Locations = [Location]

struct Location: Codable {
    let province: String
    let cities: [String]
}

/// Static data set
/// Job, school, location lists + Dummy data for community
final class DataSet {
    
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
    
    static let locationList: Locations = {
        guard let fileLocation = Bundle.main.url(forResource: "LocalInfo", withExtension: "json") else {
            NSLog("Can't get location List")
            return []
        }
        do {
            let data = try Data(contentsOf: fileLocation)
            let locationList = try! JSONDecoder().decode(Locations.self, from: data)
            return locationList
        } catch {
            return []
        }
    }()
    
    static let provinceList: [String] = {
        var prov: [String] = []
        for l in DataSet.locationList {
            prov.append(l.province)
        }
        return prov
    }()
    
    static let hotCommunities: [BoardResponse] = [
        BoardResponse(id: 0, title: "올해 상반기 공채 준비중인데",
                      content: "이번 여름방학 때 레벨업 하려고 하는데 학원보다 인강 결제가 싼 것 같던데 가나다ㅏ라라라",
                      writerId: 0, createdDate: DataSet.dates[3], edited: false),
        BoardResponse(id: 1, title: "이력서에 사진이요",
                      content: "요즘 이력서에는 사진 잘 안붙이는 블라인드 채용이 많다고 하던데 맞나요ㅠㅠ",
                      writerId: 0, createdDate: DataSet.dates[4], edited: false),
        BoardResponse(id: 2, title: "여러분 토익점수 몇 나오세요?",
                      content: "재작년에 토익을 봤었는데 좀더 점수를 올리고 싶어서 공부하고 있는데 조언구해요",
                      writerId: 1, createdDate: DataSet.dates[5], edited: false)

    ]

    static let dates: [Date] = [
        Calendar.current.date(from: DataSet.dateComponents[0])!,
        Calendar.current.date(from: DataSet.dateComponents[1])!,
        Calendar.current.date(from: DataSet.dateComponents[2])!,
        Calendar.current.date(from: DataSet.dateComponents[3])!,
        Calendar.current.date(from: DataSet.dateComponents[4])!,
        Calendar.current.date(from: DataSet.dateComponents[5])!,
    ]

    static let dateComponents: [DateComponents] = [
        DateComponents(year: 2021, month: 12, day: 1, hour: 4, minute: 20),
        DateComponents(year: 2021, month: 12, day: 2, hour: 3, minute: 00),
        DateComponents(year: 2021, month: 12, day: 11, hour: 2, minute: 40),
        DateComponents(year: 2021, month: 11, day: 22, hour: 6, minute: 15),
        DateComponents(year: 2021, month: 11, day: 22, hour: 5, minute: 39),
        DateComponents(year: 2021, month: 11, day: 18, hour: 4, minute: 20),
    ]
    
}
