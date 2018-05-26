//
//  ListPhotographersViewController.swift
//  Bahnhofsfotos
//
//  Created by Miguel Dönicke on 17.05.18.
//  Copyright © 2018 Railway-Stations. All rights reserved.
//

import UIKit

// MARK: Input
protocol ListPhotographersDisplayable: class {
  func displayPhotographers(with viewModel: ListPhotographers.ViewModel)
  func display(error: AppError)
}

// MARK: - Scene's view controller

class ListPhotographersViewController: UIViewController, AppDisplayable {

  // MARK: - Properties

  private lazy var interactor: ListPhotographersBusinessLogic = {
    let presenter = ListPhotographersPresenter(viewController: self)
    return ListPhotographersInteractor(presenter: presenter,
                                       dataStore: PhotographersAPI())
  }()

  var viewModel: ListPhotographers.ViewModel?

  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self,
                             action: #selector(fetchPhotographers),
                             for: .valueChanged)
    return refreshControl
  }()

  // MARK: - IBOutlets

  @IBOutlet weak var tableView: UITableView!

  // MARK: - View controller lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpRefreshControl()
    fetchPhotographers()
  }

  // MARK: - Private methods

  private func setUpRefreshControl() {
    tableView.refreshControl = refreshControl
  }

  @objc private func fetchPhotographers() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    refreshControl.beginRefreshing()
    interactor.fetchPhotographers()
  }

  private func endUpdating() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    refreshControl.endRefreshing()
  }

}

// MARK: - ListPhotographersDisplayable

extension ListPhotographersViewController: ListPhotographersDisplayable {

  func displayPhotographers(with viewModel: ListPhotographers.ViewModel) {
    endUpdating()
    self.viewModel = viewModel
    tableView.reloadData()
  }

  func display(error: AppError) {
    endUpdating()

    let alertController = UIAlertController(title: error.title,
                                            message: error.message,
                                            preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "OK",
                                            style: .default,
                                            handler: nil))

    present(alertController, animated: true, completion: nil)
  }

}

// MARK: - UITableViewDataSource

extension ListPhotographersViewController: UITableViewDataSource {

  var kCellIdentifier: String {
    return "scoreCell"
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.photographers.count ?? 0
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
  }

}

// MARK: - UITableViewDataSource

extension ListPhotographersViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    guard let viewModel = viewModel,
      let scoreCell = cell as? HighScoreTableViewCell else {
        return
    }

    switch indexPath.row {
    case 0: // 1st place
      scoreCell.rankImageView?.image = #imageLiteral(resourceName: "CrownGold")
    case 1: // 2nd place
      scoreCell.rankImageView?.image = #imageLiteral(resourceName: "CrownSilver")
    case 2: // 3rd place
      scoreCell.rankImageView?.image = #imageLiteral(resourceName: "CrownBronze")
    default:
      scoreCell.rankImageView?.image = nil
    }

    scoreCell.rankLabel.text = "\(indexPath.row + 1). "
    scoreCell.nameLabel.text = "\(viewModel.photographers[indexPath.row].name)"
    scoreCell.countLabel.text = "\(viewModel.photographers[indexPath.row].photoCount)"
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0: // 1st place
      return 60
    case 1: // 2nd place
      return 55
    case 2: // 3rd place
      return 50
    default:
      return 40
    }
  }

}
