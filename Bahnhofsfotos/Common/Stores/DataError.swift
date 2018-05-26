//
//  DataError.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

public enum DataError: Error {
  case nonExistent
  case database(Error?)
  case network(Error?)
  case parse(Error?)
  case unknown(Error?)
}
