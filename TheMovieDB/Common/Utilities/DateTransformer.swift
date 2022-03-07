//
//  DateTransformer.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation

struct DateTransformer {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    static func transform(_ decoded: String) -> Date {
        return Self.dateFormatter.date(from: decoded) ?? Date(timeIntervalSince1970: 0)
    }

    static func transform(_ encoded: Date) -> String {
        return Self.dateFormatter.string(from: encoded)
    }

}
