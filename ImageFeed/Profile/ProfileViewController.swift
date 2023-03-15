//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 02.03.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var avatarImage: UIImageView?
    private var nameLabel: UILabel?
    private var loginNameLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var logoutButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccountImage()
        getUserName()
        getLoginName()
        getDescription()
        getLogoutButton()
        
    }
    
    private func getAccountImage() {
        let image = UIImage(named: "avatar_icon")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        setImageConstraints(image: imageView)
        
        self.avatarImage = imageView
    }
    
    private func getUserName() {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        setUserNameConstraints(label: label)
        
        self.nameLabel = label
    }
    
    private func getLoginName() {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = UIFont.systemFont(ofSize: 13)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        setLoginName(label: label)
        
        self.loginNameLabel = label
    }
    
    private func getDescription() {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .ypWhite
        label.font = UIFont.systemFont(ofSize: 13)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        setDescription(label: label)
        
        self.descriptionLabel = label
    }
    
    private func getLogoutButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "logout_icon"), for: .normal)
        button.tintColor = .ypRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        setLogoutButton(button: button)
        
        self.logoutButton = button
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
        guard let image = avatarImage else { return }
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16)
        ])
    }
    
    private func setLoginName(label: UILabel) {
        guard let userName = nameLabel else { return }
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            label.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: userName.trailingAnchor)
        ])
    }
    
    private func setDescription(label: UILabel) {
        guard let loginName = loginNameLabel else { return }
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: loginName.leadingAnchor),
            label.topAnchor.constraint(equalTo: loginName.bottomAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: loginName.trailingAnchor)
        ])
    }
    
    private func setLogoutButton(button: UIButton) {
        guard let image = avatarImage else { return }
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: image.trailingAnchor)
        ])
    }
}
