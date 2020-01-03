//
//  BaseRepositoriesProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 01/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

enum Filter: String {
    case stars
    case updated
    case none = ""
}

class BaseRepositoriesProvider: RequestProviderProtocol {

    var httpVerb: HttpVerbs = .GET
    var path: String = "/search/repositories"
    var currentPage: Int = 1
    let itemsPerPage: Int = 10
    let filter: Filter

    var queryParameters: [URLQueryItem]? {
        return [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: filter.rawValue),
            URLQueryItem(name: "per_page", value: "\(itemsPerPage)"),
            URLQueryItem(name: "page", value: "\(currentPage)")
        ]
    }

    init(filter: Filter) {
        self.filter = filter
    }

}
