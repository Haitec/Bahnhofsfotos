//
//  API.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 15.01.17.
//  Copyright © 2017 MrHaitec. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class API {

    enum APIError: Error {
        case message(String)
    }

    // Bahnhöfe auslesen
    static func getStations(withPhoto hasPhoto: Bool, completionHandler: @escaping ([Station]) -> Void) {

        Alamofire.request(Constants.BASE_URL + "/stations",
                          method: .get,
                          parameters: ["hasPhoto": hasPhoto],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { response in

                var stations = [Station]()

                guard let json = JSON(response.result.value as Any).array else { return }

                do {
                    stations = try json.map {
                        var jsonStation = $0
                        jsonStation["hasPhoto"].bool = hasPhoto
                        guard let station = try Station(json: jsonStation) else { throw APIError.message("JSON of station is invalid.") }
                        return station
                    }
                } catch {
                    debugPrint(error)
                }

                completionHandler(stations)
            }
    }

}