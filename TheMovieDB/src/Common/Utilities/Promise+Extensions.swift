//
//  Promise+Extensions.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2022 Appaji Tholeti. All rights reserved.
//

import PromiseKit

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' unexpected input."])
    seal.reject(err)
  }
}

