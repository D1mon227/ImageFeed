//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 07.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let imagesListViewController = ImagesListViewController()
        let imagesListPresenter = ImagesListPresenter()
        let imagesListService = ImagesListService()
        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfileViewPresenter()
        
        imagesListPresenter.view = imagesListViewController
        imagesListPresenter.imagesListService = imagesListService
        imagesListViewController.presenter = imagesListPresenter
        profileViewController.presenter = profileViewPresenter
        profileViewPresenter.view = profileViewController

        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resourses.Images.tabBarItemProfile,
            selectedImage: nil)

        imagesListViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: Resourses.Images.tabBarItemFeed,
            selectedImage: nil)

        self.viewControllers = [imagesListViewController, profileViewController]

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .ypBlack
        self.tabBar.standardAppearance = appearance
        self.tabBar.tintColor = .ypWhite
    }
}
