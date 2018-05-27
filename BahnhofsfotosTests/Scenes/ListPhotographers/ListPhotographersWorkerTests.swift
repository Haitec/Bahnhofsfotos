//
//  ListPhotographersWorkerTests.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright (c) 2018 Railway-Stations. All rights reserved.
//

@testable import Bahnhofsfotos
import XCTest

class ListPhotographersWorkerTests: XCTestCase {

  // MARK: Tests

  func testShouldFetchPhotographers() {
    let spy = PhotographersStoreSpy()
    let sut = PhotographersWorker(store: spy)

    sut.fetch { _ in
      XCTAssertTrue(spy.fetchCalled)
    }
  }

}

// MARK: - Helpers

extension ListPhotographersWorkerTests {

  class PhotographersStoreSpy: PhotographersStore {
    var fetchCalled = false

    func fetch(completion: @escaping (Result<[Photographer]>) -> Void) {
      fetchCalled = true
    }
  }

}
