//
//  AppDisplayable.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 26.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

import UIKit

protocol AppDisplayable {
  func display(error: AppError)
}

extension AppDisplayable where Self: UIViewController {

  func display(error: AppError) {
    let alertController = UIAlertController(title: error.title,
                                            message: error.message,
                                            preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "OK",
                                            style: .default,
                                            handler: nil))

    let viewController = UIApplication.shared.keyWindow?.rootViewController
    viewController?.present(alertController, animated: true, completion: nil)
  }
}
