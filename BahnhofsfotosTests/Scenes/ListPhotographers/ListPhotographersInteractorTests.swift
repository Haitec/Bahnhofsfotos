//
//  ListPhotographersInteractorTests.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright (c) 2018 Railway-Stations. All rights reserved.
//

@testable import Bahnhofsfotos
import XCTest

class ListPhotographersInteractorTests: XCTestCase {

  // MARK: Tests

  func testShouldFetchPhotographers() {
    let spy = ListPhotographersPresentableSpy()
    let sut = ListPhotographersInteractor(presenter: spy,
                                          dataStore: PhotographersStoreSpy())
    sut.fetchPhotographers()

    XCTAssertEqual(spy.presentPhotographersCalled, 2)
  }

}

// MARK: - Helpers

extension ListPhotographersInteractorTests {

  class ListPhotographersPresentableSpy: ListPhotographersPresentable {
    var presentPhotographersCalled = 0

    func presentPhotographers(for response: ListPhotographers.FetchPhotographers.Response) {
      presentPhotographersCalled += 1
    }

    func presentPhotographers(error: DataError) {
      presentPhotographersCalled += 1
    }

  }

  class PhotographersStoreSpy: PhotographersStore {
    func fetch(completion: @escaping (Result<[Photographer]>) -> Void) {
      completion(.success(result: []))
      completion(.failure(error: .unknown(nil)))
    }
  }

}
