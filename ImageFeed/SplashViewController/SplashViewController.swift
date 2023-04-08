//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 26.03.2023.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    private let logoImage = UIImageView()
    
    static let didChangeNotification = Notification.Name("ProfileInfoDidRecieve")
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    
    private let imageListViewController = ImagesListViewController()
    private let oAuthService = OAuth2Service()
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplashView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = OAuth2TokenStorage().token {
            fetchProfile(token: token)
            fetchImageProfile(token: token)
            switchToTabBarController()
        } else {
            switchToAuthController()
//            performSegue(withIdentifier: showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    private func switchToAuthController() {
        let authViewController = AuthViewController()
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private func switchToTabBarController() {
//        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
//
//        //let tabBarController = TabBarController()
//        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
//            .instantiateViewController(withIdentifier: "TabBarViewController")
//
//        window.rootViewController = tabBarController
        
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    private func fetchOAuthToken(code: String) {
        oAuthService.fetchAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                self.showAlert()
                print("Ошибка получения bearer token \(error)")
            }
        }
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
                NotificationCenter.default.post(
                    name: SplashViewController.didChangeNotification,
                    object: self,
                    userInfo: ["ProfileInfo": self.profileService.profile!])
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                self.showAlert()
                print(error)
            }
        }
    }
    
    private func fetchImageProfile(token: String) {
        profileImageService.fetchProfileImageURL(token: token, username: "d1mon227") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(_):
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: ["URL": self.profileImageService.avatarURL!])
            case.failure(let error):
                self.showAlert()
                print(error)
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Что-то пошло не так(",
                                      message: "Не удалось войти в систему",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(action)
        self.present(self, animated: true)
    }
    
    private func setupSplashView() {
        view.backgroundColor = .ypBlack
        view.addSubview(logoImage)
        
        logoImage.image = UIImage(named: "launch_icon")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code: code)
        }
        UIBlockingProgressHUD.show()
    }
}

//extension SplashViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == showAuthenticationScreenSegueIdentifier {
//            guard let navigationController = segue.destination as? UINavigationController,
//                  let viewController = navigationController.viewControllers[0] as? AuthViewController
//            else { fatalError("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)") }
//            viewController.delegate = self
//            }
//        else {
//            super.prepare(for: segue, sender: sender)
//        }
//    }
//}
