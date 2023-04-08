//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 04.04.2023.
//

import Foundation

final class ProfileImageService {
    
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name("ProfileImageProviderDidChange")
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private(set) var avatarURL: String?
    
    func fetchProfileImageURL(token: String, username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        
        var request = URLRequest.makeHTTPRequest(path: "/users/\(username)", httpMethod: "GET")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let userResult):
                let smallImage = userResult.profile_image.small
                self.avatarURL = smallImage
                completion(.success(avatarURL!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
    
}
        
//        let task = object(for: request) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let userResult):
//                let smallImage = userResult.profile_image.small
//                self.avatarURL = smallImage
//                completion(.success(avatarURL!))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//        self.task = task
//        task.resume()
//    }
//}

//extension ProfileImageService {
//    func object(for request: URLRequest,
//                completion: @escaping (Result<UserResult, Error>) -> Void) -> URLSessionTask {
//        let decoder = JSONDecoder()
//        return urlSession.data(for: request) { (result: Result<Data, Error>) in
//            let responce = result.flatMap { data -> Result<UserResult, Error> in
//                Result { try decoder.decode(UserResult.self, from: data)
//                }
//            }
//            completion(responce)
//        }
//    }
//}
