//
//  DailyReportByCountryNameModel.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import Foundation
struct DailyReportByCountryNameModel: Codable {
    let country: String?
    let provinces: [Province]?
    let latitude, longitude: Double?
    let date: String?
}

// MARK: - Province
struct Province: Codable {
    let province: String?
    let confirmed, recovered, deaths, active: Int?
}
