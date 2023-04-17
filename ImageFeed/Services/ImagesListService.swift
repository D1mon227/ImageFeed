//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 17.04.2023.
//

import Foundation

final class ImagesListService {
    
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    
    func fetchPhotosNextPage() {
        
        assert(Thread.isMainThread)
        if task != nil { return }
        
        let nextPage = lastLoadedPage == nil ? 1 : lastLoadedPage! + 1
        
        var request = URLRequest.makeHTTPRequest(path: "/photos" + "/?page=\(lastLoadedPage!)", httpMethod: "GET")
        request.setValue("Bearer \(OAuth2TokenStorage().token!)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let photosResult):
                photosResult.forEach { photo in
                    let date = DateFormatter().date(from: photo.createdAt)
                    guard let thumbImage = photo.urls.thumb,
                          let fullImage = photo.urls.full else { return }
                    self.photos.append(Photo(id: photo.id,
                                             size: CGSize(width: photo.width, height: photo.height),
                                             createdAt: date,
                                             welcomeDescription: photo.description,
                                             thumbImageURL: thumbImage,
                                             largeImageURL: fullImage,
                                             isLiked: false))
                }
                NotificationCenter.default.post(
                    name: ImagesListService.didChangeNotification,
                    object: self,
                    userInfo: ["Photos": self.photos])
                lastLoadedPage = nextPage
            case .failure(let error):
                print(error)
            }
        }
        self.task = task
        task.resume()
    }
}
