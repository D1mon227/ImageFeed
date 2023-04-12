//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.03.2023.
//

import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
