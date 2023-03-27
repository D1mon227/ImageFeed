//
//  Constants.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 17.03.2023.
//

import Foundation

struct Constants {
    static let accessKey = "mq2dzPa0enc8ys3Sy2H7eiqSQBH2wU1l8Ipk2OS0XbY"
    static let secretKey = "qfgHCD3RlMjTxXoQs3FxHZzWaIjCphBguZVi6LgUYw4"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseUrl = URL(string: "https://api.unsplash.com")
    static let authorizeURl = "https://unsplash.com/oauth/authorize"
    static let urlPathToAuthorize = "/oauth/authorize/native"
    static let urlToFetchAuthToken = "https://unsplash.com/oauth/token"
}
struct Parameters {
    static let client_id = "client_id"
    static let client_secret = "client_secret"
    static let redirect_uri = "redirect_uri"
    static let response_type = "response_type"
    static let code = "code"
    static let scope = "scope"
    static let grantType = "grant_type"
    static let authorizationCode = "authorization_code"
}
