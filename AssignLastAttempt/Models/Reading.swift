//
//  Reading.swift
//  AssignLastAttempt
//
//  Created by German Randhawa on 2023-11-19.
//

import Foundation

struct Reading: Codable, Identifiable {
    var Condition: String
    var Diastolic: Int
    var Systolic: Int
    var id: String
    var readingDate: TimeInterval
}
