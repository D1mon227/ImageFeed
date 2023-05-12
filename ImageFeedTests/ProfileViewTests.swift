//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Dmitry Medvedev on 10.05.2023.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTests: XCTestCase {
    
    func testProfileViewControllerCallsViewDidLoad() {
        //given
        let profileViewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        profileViewController.presenter = presenter
        presenter.view = profileViewController
        
        //when
        _ = profileViewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    func testProfileInfoObserver() {
        //given
        
    }
}
