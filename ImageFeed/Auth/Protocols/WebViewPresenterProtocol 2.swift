//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 04.05.2023.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}
