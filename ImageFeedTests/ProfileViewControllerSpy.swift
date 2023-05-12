//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

import Foundation
@testable import ImageFeed

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed.ProfileViewPresenterProtocol?
    
    func updateAvatar() {}
    
    func updateProfileDetails(profile: ImageFeed.Profile?) {}
    
}
