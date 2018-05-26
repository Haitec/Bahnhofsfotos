//
//  PhotographersStore.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

protocol PhotographersStore {
  func fetch(completion: @escaping (Result<[Photographer]>) -> Void)
}
