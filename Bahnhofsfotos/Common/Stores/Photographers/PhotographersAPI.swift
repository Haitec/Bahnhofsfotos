//
//  PhotographersAPI.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyUserDefaults

class PhotographersAPI: PhotographersStore {

  func fetch(completion: @escaping (Result<[Photographer]>) -> Void) {
    var parameters = Parameters()
    if Defaults[.country].count > 0 {
      parameters["country"] = Defaults[.country].lowercased()
    }

    Alamofire.request(API.baseUrl + "/photographers",
                      method: .get,
                      parameters: parameters,
                      encoding: URLEncoding.default,
                      headers: nil)
      .responseJSON { response in

        guard response.result.isSuccess else {
          return completion(.failure(error: .network(response.result.error)))
        }

        guard let dict = response.result.value as? [String: Int] else {
          return completion(.failure(error: .parse(nil)))
        }

        let photographers = dict.map {
          Photographer(name: $0.key, photoCount: $0.value)
        }

        completion(.success(result: photographers))
    }
  }

}
