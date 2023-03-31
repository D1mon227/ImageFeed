//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.03.2023.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_vc: WebViewViewController)
}
