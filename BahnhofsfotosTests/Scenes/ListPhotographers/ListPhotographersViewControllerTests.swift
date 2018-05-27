//
//  ListPhotographersViewControllerTests.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright (c) 2018 Railway-Stations. All rights reserved.
//

@testable import Bahnhofsfotos
import XCTest

class ListPhotographersViewControllerTests: XCTestCase {

  // MARK: Software under test

  var sut: ListPhotographersViewController!
  var window: UIWindow!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupListPhotographersViewController()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }


  // MARK: Test setup

  func setupListPhotographersViewController() {
    let storyboard = UIStoryboard(name: "ListPhotographers", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "ListPhotographersViewController") as! ListPhotographersViewController
  }

  // MARK: Tests

  func testShouldFetchPhotographersWhenViewIsLoaded() {
    let spy = ListPhotographersBusinessLogicSpy()
    sut.interactor = spy

    sut.loadViewIfNeeded()

    XCTAssertTrue(spy.fetchPhotographersCalled)
  }

  func testShouldDisplayThreePhotographers() {
    let viewModel = ListPhotographers.ViewModel(photographers: [
      ListPhotographers.PhotographerViewModel(name: "@ghostlockd", photoCount: 313373),
      ListPhotographers.PhotographerViewModel(name: "@mrhaitec", photoCount: 1337),
      ListPhotographers.PhotographerViewModel(name: "Miguel", photoCount: 1)
    ])

    sut.loadViewIfNeeded()
    sut.displayPhotographers(with: viewModel)

    XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)

    let p1 = sut.tableView.cell(at: 0) as? HighScoreTableViewCell
    XCTAssertNotNil(p1)
    XCTAssertEqual(p1?.rankLabel.text, "1. ")
    XCTAssertEqual(p1?.nameLabel.text, viewModel.photographers[0].name)
    XCTAssertEqual(p1?.countLabel.text, "\(viewModel.photographers[0].photoCount)")
    XCTAssertEqual(p1?.rankImageView.image, #imageLiteral(resourceName: "CrownGold"))

    let p2 = sut.tableView.cell(at: 1) as? HighScoreTableViewCell
    XCTAssertNotNil(p2)
    XCTAssertEqual(p2?.rankLabel.text, "2. ")
    XCTAssertEqual(p2?.nameLabel.text, viewModel.photographers[1].name)
    XCTAssertEqual(p2?.countLabel.text, "\(viewModel.photographers[1].photoCount)")
    XCTAssertEqual(p2?.rankImageView.image, #imageLiteral(resourceName: "CrownSilver"))

    let p3 = sut.tableView.cell(at: 2) as? HighScoreTableViewCell
    XCTAssertNotNil(p3)
    XCTAssertEqual(p3?.rankLabel.text, "3. ")
    XCTAssertEqual(p3?.nameLabel.text, viewModel.photographers[2].name)
    XCTAssertEqual(p3?.countLabel.text, "\(viewModel.photographers[2].photoCount)")
    XCTAssertEqual(p3?.rankImageView.image, #imageLiteral(resourceName: "CrownBronze"))
  }

}

// MARK: - Helpers

extension ListPhotographersViewControllerTests {

  class ListPhotographersBusinessLogicSpy: ListPhotographersBusinessLogic {

    var fetchPhotographersCalled = false

    func fetchPhotographers() {
      fetchPhotographersCalled = true
    }

  }

}

extension UITableView {

  func cell(at row: Int) -> UITableViewCell? {
    let indexPath = IndexPath(row: row, section: 0)
    guard let cell = dataSource?.tableView(self, cellForRowAt: indexPath) else { return nil }
    delegate?.tableView!(self, willDisplay: cell, forRowAt: indexPath)
    return cell
  }

}
