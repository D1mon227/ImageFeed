//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.02.2023.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

extension Date {
    var currentDate: String { dateFormatter.string(from: Date()) }
}
