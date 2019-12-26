//
//  MainModels.swift
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

enum Main {

    struct Response: Decodable {
        let items: [RepositoryDomain]
    }

    struct Mapper {
        static func repoCellViewModel(repositories: [RepositoryDomain]) -> [RepositoryCellViewModel] {
            return repositories.compactMap { RepositoryCellViewModel(repository: $0, cellType: .repositories) }
        }

        static func newsCellViewModel(topRepos: [RepositoryDomain], mostRecent: [RepositoryDomain]) -> [RepositoryCellViewModel] {
            let topReposImages = topRepos.compactMap { $0.owner.avatar }
            let lastUpdatedImages = mostRecent.compactMap { $0.owner.avatar }
            return [
                RepositoryCellViewModel(cellType: .news, title: "MELHORES REPOSITORIOS", name: "Os repositorios renomados", description: "As melhores ferramentas", images: topReposImages),
                RepositoryCellViewModel(cellType: .news, title: "REPOSITORIOS ATUALIZADOS", name: "As ultimas atualizacoes", description: "Repositorios mais atualizados", images: lastUpdatedImages)
            ]
        }
    }

    struct ViewModel {
        let news: [RepositoryCellViewModel]
        let topRepos: [RepositoryCellViewModel]
        let mostRecent: [RepositoryCellViewModel]

        init(news: [RepositoryCellViewModel] = [], topRepos: [RepositoryCellViewModel] = [], mostRecent: [RepositoryCellViewModel] = []) {
            self.news = news
            self.topRepos = topRepos
            self.mostRecent = mostRecent
        }
    }

    struct RepositoryCellViewModel: MainCollectionViewModelProtocol {

        var cellType: MainCollectionViewCell
        var title: String?
        var name: String
        var description: String
        var images: [URL]

        init(cellType: MainCollectionViewCell, title: String?, name: String, description: String, images: [URL]) {
            self.cellType = cellType
            self.title = title
            self.name = name
            self.description = description
            self.images = images
        }

        init(repository: RepositoryDomain, cellType: MainCollectionViewCell, title: String? = nil) {
            self.cellType = cellType
            self.name = repository.owner.name
            self.description = repository.description ?? ""
            self.images = [repository.owner.avatar]
            self.title = title
        }
    }

}
