//
//  ScheduleResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation

typealias Schedules = [Schedule]

struct Schedule: Codable, Hashable {
    let matchingId, mentoId, appointmentTime, nickName, company, year: String
    let location: String
    let profileImage, job, untact: String
}
