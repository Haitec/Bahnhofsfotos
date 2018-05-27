//
//  ListPhotographersPresenterTests.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright (c) 2018 Railway-Stations. All rights reserved.
//

@testable import Bahnhofsfotos
import XCTest

class ListPhotographersPresenterTests: XCTestCase {

  // MARK: Tests

  func testShouldPresentThreePhotographersInCorrectOrder() {
    let p1 = Photographer(name: "@ghostlockd", photoCount: 313373)
    let p2 = Photographer(name: "@mrhaitec", photoCount: 1337)
    let p3 = Photographer(name: "Miguel", photoCount: 1)


    let spy = ListPhotographersDisplayableSpy()
    let sut = ListPhotographersPresenter(viewController: spy)
    let response = ListPhotographers.FetchPhotographers.Response(photographers: [
      p2,
      p3,
      p1
    ])

    sut.presentPhotographers(error: .unknown(nil))
    XCTAssertTrue(spy.displayErrorCalled)

    sut.presentPhotographers(for: response)
    XCTAssertTrue(spy.displayPhotographersCalled)

    XCTAssertEqual(spy.viewModel?.photographers[0].name, p1.name)
    XCTAssertEqual(spy.viewModel?.photographers[1].name, p2.name)
    XCTAssertEqual(spy.viewModel?.photographers[2].name, p3.name)
  }

}

// MARK: - Helpers

extension ListPhotographersPresenterTests {

  class ListPhotographersDisplayableSpy: ListPhotographersDisplayable {

    var viewModel: ListPhotographers.ViewModel?
    var displayPhotographersCalled = false
    var displayErrorCalled = false

    func displayPhotographers(with viewModel: ListPhotographers.ViewModel) {
      displayPhotographersCalled = true
      self.viewModel = viewModel
    }

    func display(error: AppError) {
      displayErrorCalled = true
    }

  }

}
