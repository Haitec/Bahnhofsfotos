//
//  PhotographersWorker.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

struct PhotographersWorker {

  private let store: PhotographersStore

  init(store: PhotographersStore) {
    self.store = store
  }

}

extension PhotographersWorker {

  func fetch(completion: @escaping (Result<[Photographer]>) -> Void) {
     store.fetch(completion: completion)
  }

}
