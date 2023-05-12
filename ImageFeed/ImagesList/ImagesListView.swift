//
//  ImagesListView.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

import UIKit

final class ImagesListView {
    lazy var tableView: UITableView = {
        let element = UITableView()
        element.backgroundColor = .ypBlack
        element.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        element.register(ImagesListCell.self, forCellReuseIdentifier: "ImagesListCell")
        return element
    }()
}
