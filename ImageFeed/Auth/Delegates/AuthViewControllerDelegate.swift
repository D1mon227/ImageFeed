//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.03.2023.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}
