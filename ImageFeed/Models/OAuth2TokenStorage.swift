//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 22.03.2023.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    private let keychainWrapper = KeychainWrapper.standard
    
    enum Keys: String {
        case bearerToken
    }
    
    var token: String? {
        get {
            return keychainWrapper.string(forKey: Keys.bearerToken.rawValue)
        }
        set {
            keychainWrapper.set(newValue!, forKey: Keys.bearerToken.rawValue)
        }
    }
    
    func deleteToken() {
        keychainWrapper.removeObject(forKey: Keys.bearerToken.rawValue)
    }
}
