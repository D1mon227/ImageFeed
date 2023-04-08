//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 21.03.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let webViewSegueIdentifier = "ShowWebView"
    
    private let authImage = UIImageView()
    private let sighInButton = UIButton()
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        addViews()
        setupViews()
        addConstraints()
    }
    
    private func addViews() {
        view.addSubview(authImage)
        view.addSubview(sighInButton)
    }
        
    private func setupViews() {
        authImage.image = UIImage(named: "auth_screen_logo")
        sighInButton.backgroundColor = .ypWhite
        sighInButton.setTitle("Войти", for: .normal)
        sighInButton.setTitleColor(.ypBlack, for: .normal)
        sighInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        sighInButton.layer.cornerRadius = 16
        sighInButton.layer.masksToBounds = true
        sighInButton.addTarget(self, action: #selector(moveToWebView), for: .touchUpInside)
    }
    
    private func addConstraints() {
        authImage.translatesAutoresizingMaskIntoConstraints = false
        sighInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authImage.widthAnchor.constraint(equalToConstant: 60),
            authImage.heightAnchor.constraint(equalToConstant: 60),
            authImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sighInButton.heightAnchor.constraint(equalToConstant: 48),
            sighInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sighInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            sighInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
    }
    
    @objc private func moveToWebView() {
//        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration")}
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController")
//        window.rootViewController = webViewController
        webViewController.modalPresentationStyle = .fullScreen
        present(webViewController, animated: true)
        
//        let webViewController = WebViewViewController()
//        webViewController.modalPresentationStyle = .fullScreen
//        present(webViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == webViewSegueIdentifier {
            guard let webViewController = segue.destination as? WebViewViewController else {
                fatalError("Failed to prepare for \(webViewSegueIdentifier)") }
            webViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
