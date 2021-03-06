//
//  FeedPresenter.swift
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

protocol FeedPresentationLogic {
    func mapResponse(_ topRepoResponse: Repositories, _ mostRecentResponse: Repositories)
    func presentList()
    func presentDetail()
    func presentTryAgain(message: String)
}

class FeedPresenter: FeedPresentationLogic {

    weak var viewController: FeedDisplayLogic?

    func mapResponse(_ topRepoResponse: Repositories, _ lastUpdatedtResponse: Repositories) {
        let topRepoViewModel = Feed.MapRepoViewModel(repositories: topRepoResponse.items, section: .topRepos)
        let lastUpdatedViewModel = Feed.MapRepoViewModel(repositories: lastUpdatedtResponse.items, section: .lastUpdated)
        let newsViewModel = Feed.MapNewsViewModel(topRepos: topRepoResponse.items, lastUpdated: lastUpdatedtResponse.items)

        let viewModel = Feed.ViewModel(news: newsViewModel, topRepos: topRepoViewModel, lastUpdated: lastUpdatedViewModel)
        viewController?.show(viewModel)
    }

    func presentTryAgain(message: String) {
        viewController?.showTryAgain(title: Text.anErrorHappened.value, message: message)
    }

    func presentList() {
        viewController?.showList()
    }

    func presentDetail() {
        viewController?.showDetail()
    }

}
