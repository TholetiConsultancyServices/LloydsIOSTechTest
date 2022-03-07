//
//  DateFormatter+CustomFormatter.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation

extension DateFormatter {

    static private let customDateFormatter = DateFormatter()

    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }

    static func date(from string: String, format: String) -> Date? {
        customDateFormatter.dateFormat = format
        return customDateFormatter.date(from: string)
    }

}
