//
//  ListPhotographers.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 17.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

enum ListPhotographers {

  // MARK: - Use cases

  enum FetchPhotographers {

    struct Request { }

    struct Response {
      let photographers: [Photographer]
    }

  }

  // MARK: - View models

  struct ViewModel {
    let photographers: [PhotographerViewModel]
  }

  struct PhotographerViewModel {
    let name: String
    let photoCount: Int
  }

}
