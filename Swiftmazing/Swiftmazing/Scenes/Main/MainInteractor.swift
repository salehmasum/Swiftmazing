//
//  MainInteractor.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
// This tag below is used to create the testable files from the Cuckoo pod
// CUCKOO_TESTABLE

import UIKit
import PromiseKit

protocol MainBusinessLogic {
    func loadScreen()
    func repositorySelected(_ repository: Repository?)
    func topRepoListSelected(_ repositories: [Repository], title: String)
    func lastUpdatedListSelected(_ repositories: [Repository], title: String)
}

protocol MainDataStore {
    var selectedRepository: Repository? { get set }
    var listTitle: String { get set }
    var listProvider: BaseRepositoriesProvider? { get set }
    var listRepositories: [Repository] { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {

    var presenter: MainPresentationLogic?
    let worker: RepositoriesWorker
    let topRepositoriesProvider = TopRepositoriesProvider()
    let lastUpdatedRepositoriesProvider = LastUpdatedRepositoriesProvider()

    // MARK: DATASTORE
    var listTitle: String = ""
    var listProvider: BaseRepositoriesProvider?
    var listRepositories: [Repository] = []
    var selectedRepository: Repository?

    init(worker: RepositoriesWorker = RepositoriesWorker()) {
        self.worker = worker
    }

    func loadScreen() {
        let topRepo = worker.getRepositories(from: topRepositoriesProvider)
        let lastUpdated = worker.getRepositories(from: lastUpdatedRepositoriesProvider)

        when(fulfilled: topRepo, lastUpdated).done(handleSuccess).cauterize()
    }

    func handleSuccess(_ topRepoResponse: Repositories, _ lastUpdatedResponse: Repositories) {
        presenter?.mapResponse(topRepoResponse, lastUpdatedResponse)
    }

    func repositorySelected(_ repository: Repository?) {

    }

    func topRepoListSelected(_ repositories: [Repository], title: String) {
        listRepositories = repositories
        listProvider = topRepositoriesProvider
        listTitle = title
        presenter?.presentList()
    }

    func lastUpdatedListSelected(_ repositories: [Repository], title: String) {
        listRepositories = repositories
        listProvider = lastUpdatedRepositoriesProvider
        listTitle = title
        presenter?.presentList()
    }

}
