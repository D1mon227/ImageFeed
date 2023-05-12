//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 21.03.2023.
//

import UIKit
import SnapKit

final class AuthViewController: UIViewController {
    
    weak var delegate: AuthViewControllerDelegate?
    private let authView = AuthView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        addViews()
    }
    
    @objc private func moveToWebView() {
        let webViewController = WebViewViewController()
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webViewController.presenter = webViewPresenter
        webViewPresenter.view = webViewController
        webViewController.delegate = self
        webViewController.modalPresentationStyle = .fullScreen
        present(webViewController, animated: true)
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}

extension AuthViewController {
    private func addViews() {
        view.addSubview(authView.authImage)
        view.addSubview(authView.sighInButton)
        authView.sighInButton.addTarget(self, action: #selector(moveToWebView), for: .touchUpInside)
        addConstraints()
    }
    
    private func addConstraints() {
        authView.authImage.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.center.equalTo(view.snp.center)
        }
        
        authView.sighInButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(90)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
