//
//  Sorting.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

struct Sorting {
    enum Key: String {
        case date
        case rating
    }

    enum Order: Int, CaseIterable {
        case descending
        case ascending

        var networkValue: String {
            switch self {
            case .ascending: return "asc"
            case .descending: return "desc"
            }
        }

        var userInterfaceValue: String {
            switch self {
                case .ascending: return "ascending"
                case .descending: return "descending"
            }
        }
    }

    let key: Key
    let order: Order
}
