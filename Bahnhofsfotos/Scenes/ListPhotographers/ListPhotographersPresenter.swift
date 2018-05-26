//
//  ListPhotographersPresenter.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 17.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

protocol ListPhotographersPresentable {
  func presentPhotographers(for response: ListPhotographers.FetchPhotographers.Response)
  func presentPhotographers(error: DataError)
}

class ListPhotographersPresenter {

  private weak var viewController: ListPhotographersDisplayable?

  init(viewController: ListPhotographersDisplayable?) {
    self.viewController = viewController
  }

}

// MARK: - ListPhotographersPresentable

extension ListPhotographersPresenter: ListPhotographersPresentable {

  func presentPhotographers(for response: ListPhotographers.FetchPhotographers.Response) {
    var photographers = response.photographers.map {
      ListPhotographers.PhotographerViewModel(name: $0.name, photoCount: $0.photoCount)
    }
    photographers.sort { $0.photoCount > $1.photoCount }
    let viewModel = ListPhotographers.ViewModel(photographers: photographers)
    viewController?.displayPhotographers(with: viewModel)
  }

  func presentPhotographers(error: DataError) {
    let viewModel = AppError(title: "Fehler", message: "Daten konnten nicht geladen werden.")
    viewController?.display(error: viewModel)
  }

}
