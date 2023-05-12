//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

import UIKit
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var view: ImageFeed.ProfileViewControllerProtocol?
    var viewDidLoad: Bool = false
    
    func showLogoutAlert(vc: UIViewController) {
        
    }
    
    func profileImageObserver() {
        viewDidLoad = true
    }
    
    func profileInfoObserver() {
        
    }
    
    
}
