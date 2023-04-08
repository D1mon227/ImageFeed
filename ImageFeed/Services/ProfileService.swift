//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 02.04.2023.
//

import UIKit

final class ProfileService {
    
    static let shared = ProfileService()
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private(set) var profile: Profile?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        if task != nil {
            return
        }
        
        var request = URLRequest.makeHTTPRequest(path: "/me", httpMethod: "GET")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let unsplashProfile):
                self.profile = Profile(username: unsplashProfile.username,
                                       first_name: unsplashProfile.first_name,
                                       last_name: unsplashProfile.last_name,
                                       bio: unsplashProfile.bio)
                UIBlockingProgressHUD.dismiss()
                completion(.success(self.profile!))
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
//            case .success(let unsplashProfile):
//                self.profile = Profile(username: unsplashProfile.username,
//                                       first_name: unsplashProfile.first_name,
//                                       last_name: unsplashProfile.last_name,
//                                       bio: unsplashProfile.bio)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//        self.task = task
//        task.resume()
//    }
//}

//extension ProfileService {
//    func object(for request: URLRequest,
//                completion: @escaping (Result<ProfileResult, Error>) -> Void) -> URLSessionTask {
//        let decoder = JSONDecoder()
//        return urlSession.data(for: request) { (result: Result<Data, Error>) in
//            let responce = result.flatMap { data -> Result<ProfileResult, Error> in
//                Result { try decoder.decode(ProfileResult.self, from: data)
//                }
//            }
//            completion(responce)
//        }
//    }
//}
