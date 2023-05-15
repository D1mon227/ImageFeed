//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Dmitry Medvedev on 14.05.2023.
//

import Foundation
@testable import ImageFeed

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImageFeed.ImagesListPresenterProtocol?
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        
    }
}
