//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 21.03.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
//    @IBOutlet private var webView: WKWebView!
//    @IBOutlet private var progressView: UIProgressView!
    
    private let webView = WKWebView()
    private let backButton = UIButton(type: .system)
    private let progressView = UIProgressView()

    private var estimatedProgressObservation: NSKeyValueObservation?
    weak var delegate: WebViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addConstraints()
        setupViews()
        webView.navigationDelegate = self
        requestToUnsplash()
        
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 self.updateProgress()
             })
    }
    
//    @IBAction private func didTapBackButton(_ sender: Any?) {
//        delegate?.webViewViewControllerDidCancel(_vc: self)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressView.isHidden = true
        //webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    private func requestToUnsplash() {
        guard var urlComponents = URLComponents(string: Constants.authorizeURl) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: Parameters.client_id, value: Constants.accessKey),
            URLQueryItem(name: Parameters.redirect_uri, value: Constants.redirectURI),
            URLQueryItem(name: Parameters.response_type, value: Parameters.code),
            URLQueryItem(name: Parameters.scope, value: Constants.accessScope)
        ]
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func addView() {
        view.addSubview(webView)
        view.addSubview(backButton)
        view.addSubview(progressView)
    }
    
    private func addConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 9),

            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupViews() {
        view.backgroundColor = .ypWhite
        webView.backgroundColor = .ypWhite
        webView.contentMode = .scaleToFill

        backButton.setImage(UIImage(named: "nav_back_button"), for: .normal)
        backButton.tintColor = .ypBlack
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        progressView.tintColor = .ypBlack
    }

    @objc private func backButtonAction() {
       // dismiss(animated: true)
        delegate?.webViewViewControllerDidCancel(self)
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = code(from: navigationAction) {
            self.delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }

    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == Constants.urlPathToAuthorize,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == Parameters.code })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}

