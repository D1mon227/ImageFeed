//
//  AuthView.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

import UIKit

final class AuthView {
    lazy var authImage: UIImageView = {
        let element = UIImageView()
        element.image = Resourses.Images.authScreenLogo
        return element
    }()
    
    lazy var sighInButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .ypWhite
        element.setTitle("Войти", for: .normal)
        element.setTitleColor(.ypBlack, for: .normal)
        element.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        element.layer.cornerRadius = 16
        element.layer.masksToBounds = true
        element.accessibilityIdentifier = "Authenticate"
        return element
    }()
}
