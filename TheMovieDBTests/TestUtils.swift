//
//  MovieDBTestBase.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import XCTest

class TestUtils {
    
    func loadJson<T: Decodable>(filename fileName: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return T(jsonData: data)
    }

    func loadImageData(filename fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "png") else {
            return nil
        }

        return try? Data(contentsOf: url)
    }
}
