//
//  Result.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

enum Result<R> {

  case success(result: R)
  case failure(error: DataError)

  /// Returns `true` if the result is a success, `false` otherwise.
  public var isSuccess: Bool {
    switch self {
    case .success:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if the result is a failure, `false` otherwise.
  public var isFailure: Bool {
    return !isSuccess
  }

  /// Returns the associated value if the result is a success, `nil` otherwise.
  public var value: R? {
    switch self {
    case .success(let value):
      return value
    default:
      return nil
    }
  }

  /// Returns the associated error value if the result is a failure, `nil` otherwise.
  public var error: DataError? {
    switch self {
    case .failure(let error):
      return error
    default:
      return nil
    }
  }

}
