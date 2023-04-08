//
//  OAuth2ServiceProtocol.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.03.2023.
//

import Foundation

protocol OAuth2ServiceProtocol {
    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) -> Void
}
