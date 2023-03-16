//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 02.03.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let avatarImage = UIImageView()
    private let nameLabel = UILabel()
    private let loginNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccountImage()
        getUserName()
        getLoginName()
        getDescription()
        getLogoutButton()
        
    }
    
    private func getAccountImage() {
        avatarImage.image = UIImage(named: "avatar_icon")
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImage)
        setImageConstraints(image: avatarImage)
    }
    
    private func getUserName() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        setUserNameConstraints(label: nameLabel)
    }
    
    private func getLoginName() {
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = .ypGray
        loginNameLabel.font = UIFont.systemFont(ofSize: 13)
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        setLoginName(label: loginNameLabel)
    }
    
    private func getDescription() {
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        setDescription(label: descriptionLabel)
    }
    
    private func getLogoutButton() {
        logoutButton.setImage(UIImage(named: "logout_icon"), for: .normal)
        logoutButton.tintColor = .ypRed
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        setLogoutButton(button: logoutButton)
    }
    
    private func setImageConstraints(image: UIImageView) {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 70),
            image.heightAnchor.constraint(equalToConstant: 70),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    private func setUserNameConstraints(label: UILabel) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            label.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16)
        ])
    }
    
    private func setLoginName(label: UILabel) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    private func setDescription(label: UILabel) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: loginNameLabel.leadingAnchor),
            label.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: loginNameLabel.trailingAnchor)
        ])
    }
    
    private func setLogoutButton(button: UIButton) {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: avatarImage.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor)
        ])
    }
}
