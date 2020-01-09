//
//  FeedInteractor.swift
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

protocol FeedBusinessLogic {
    func loadScreen()
    func repositorySelected(_ repository: Repository?)
    func topRepoListSelected(_ repositories: [Repository], title: String)
    func lastUpdatedListSelected(_ repositories: [Repository], title: String)
}

protocol FeedDataStore {
    var selectedRepository: Repository? { get set }
    var listTitle: String { get set }
    var listFilter: Filter { get set }
    var listRepositories: [Repository] { get set }
}

class FeedInteractor: FeedBusinessLogic, FeedDataStore {

    var presenter: FeedPresentationLogic?
    let worker: RepositoriesWorker

    // MARK: DATASTORE
    var listTitle: String = ""
    var listFilter: Filter = .none
    var listRepositories: [Repository] = []
    var selectedRepository: Repository?

    init(worker: RepositoriesWorker = RepositoriesWorker()) {
        self.worker = worker
    }

    func loadScreen() {
        let topRepo = worker.getRepositories(with: .stars)
        let lastUpdated = worker.getRepositories(with: .updated)

        when(fulfilled: topRepo, lastUpdated).done(handleSuccess).cauterize()
    }

    func handleSuccess(_ topRepoResponse: Repositories, _ lastUpdatedResponse: Repositories) {
        presenter?.mapResponse(topRepoResponse, lastUpdatedResponse)
    }

    func repositorySelected(_ repository: Repository?) {
        selectedRepository = repository
        presenter?.presentDetail()
    }

    func topRepoListSelected(_ repositories: [Repository], title: String) {
        listRepositories = repositories
        listFilter = .stars
        listTitle = title
        presenter?.presentList()
    }

    func lastUpdatedListSelected(_ repositories: [Repository], title: String) {
        listRepositories = repositories
        listFilter = .updated
        listTitle = title
        presenter?.presentList()
    }

}
