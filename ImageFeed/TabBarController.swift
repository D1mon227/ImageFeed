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
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")

        let profileViewController = ProfileViewController()

        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil)

        imagesListViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_editorial_active"),
            selectedImage: nil)

        self.viewControllers = [imagesListViewController, profileViewController]

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .ypBlack
        self.tabBar.standardAppearance = appearance
        self.tabBar.tintColor = .ypWhite
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
//
//        let profileViewController = ProfileViewController()
//
//        profileViewController.tabBarItem = UITabBarItem(
//            title: nil,
//            image: UIImage(named: "tab_profile_active"),
//            selectedImage: nil)
//
//        imagesListViewController.tabBarItem = UITabBarItem(
//            title: nil,
//            image: UIImage(named: "tab_editorial_active"),
//            selectedImage: nil)
//
//        self.viewControllers = [imagesListViewController, profileViewController]
//    }
}
