//
//  MainViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Visual

protocol MainDisplayLogic: class {
}

class MainViewController: MainCollectionView {

    var interactor: MainBusinessLogic?
    var router: (MainRoutingLogic & MainDataPassing)?

    override func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        router.dataStore = interactor
    }
  
}

extension MainViewController: MainDisplayLogic {

}

extension MainViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RepositoryMainCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
