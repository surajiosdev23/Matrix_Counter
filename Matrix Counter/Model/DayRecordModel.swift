//
//  DayRecordModel.swift
//  Matrix Counter
//
//  Created by suraj jadhav on 12/02/24.
//

import Foundation
// MARK: - DayEndRecordModelElement
struct DayEndRecordModelElement: Codable {
    let hours: [Hour]?
    let day: String?
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String?
    let recordCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case hour
        case recordCount = "record_count"
    }
}
struct DayData: Decodable {
    let hours: [Hour]
    let day: String
}
typealias DayRecordModel = [DayEndRecordModelElement]
