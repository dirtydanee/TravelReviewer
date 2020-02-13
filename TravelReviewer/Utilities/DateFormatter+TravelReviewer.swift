//
//  DateFormatter+TravelReviewer.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var `default`: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }
}
