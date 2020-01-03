//
//  MainRouter.swift
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

@objc protocol MainRoutingLogic {
    func routeToList()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: MainRoutingLogic, MainDataPassing {

    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

    func routeToList() {
        let destinationViewController = ListViewController()
        var destinationDataStore = destinationViewController.router?.dataStore
        passDataToList(source: dataStore, destination: &destinationDataStore)
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }

    func passDataToList(source: MainDataStore?, destination: inout ListDataStore?) {
        destination?.listProvider = source?.listProvider
        destination?.listRepositories = source?.listRepositories ?? []
        destination?.listTitle = source?.listTitle ?? ""
    }

}
