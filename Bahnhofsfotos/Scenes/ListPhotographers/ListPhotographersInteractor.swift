//
//  ListPhotographersInteractor.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 17.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

import Foundation

// MARK: Input
protocol ListPhotographersBusinessLogic {
  func fetchPhotographers()
}

// MARK: - Business logic

class ListPhotographersInteractor: ListPhotographersBusinessLogic {

  private let presenter: ListPhotographersPresentable
  private let worker: PhotographersWorker

  init(presenter: ListPhotographersPresentable,
       dataStore: PhotographersStore) {
    self.presenter = presenter
    worker = PhotographersWorker(store: dataStore)
  }

  func fetchPhotographers() {
    worker.fetch { result in
      guard let photographers = result.value, result.isSuccess else {
        let error = result.error ?? .unknown(nil)
        return self.presenter.presentPhotographers(error: error)
      }

      let response = ListPhotographers.FetchPhotographers.Response(photographers: photographers)
      self.presenter.presentPhotographers(for: response)
    }
  }

}
