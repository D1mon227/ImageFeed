//
//  SingleImageView.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

import UIKit

final class SingleImageView {
    lazy var backButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setImage(Resourses.Images.backButtonWhite, for: .normal)
        element.accessibilityIdentifier = "BackButton"
        return element
    }()

    lazy var shareButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setImage(Resourses.Images.shareImage, for: .normal)
        return element
    }()

    lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        return element
    }()

    lazy var singleImageView: UIImageView = {
        let element = UIImageView()
        return element
    }()
}
