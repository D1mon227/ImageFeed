//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 13.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class SingleImageViewController: UIViewController {
    
    var imageUrl: URL?
    let singleImageView = SingleImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        addViews()
        
        showLargeImage(url: imageUrl!)
        singleImageView.scrollView.delegate = self
        singleImageView.scrollView.minimumZoomScale = 0.1
        singleImageView.scrollView.maximumZoomScale = 1.25
    }
    
    @objc private func share() {
        guard let shareImage = singleImageView.singleImageView.image else { return }
        let shareController = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        present(shareController, animated: true)
    }
    
    @objc private func backToFeed() {
        dismiss(animated: true)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = singleImageView.scrollView.minimumZoomScale
        let maxZoomScale = singleImageView.scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = singleImageView.scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.height / imageSize.height
        let wScale = visibleRectSize.width / imageSize.width
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, wScale)))
        singleImageView.scrollView.setZoomScale(scale, animated: false)
        singleImageView.scrollView.layoutIfNeeded()
        let newContentSize = singleImageView.scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        singleImageView.scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func showLargeImage(url: URL) {
        guard isViewLoaded else { return }
        UIBlockingProgressHUD.show()
        singleImageView.singleImageView.kf.setImage(with: url) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let imageResult):
                self.rescaleAndCenterImageInScrollView(image: imageResult.image)
            case .failure(_):
                self.showErrorAlert()
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Что-то пошло не так.",
                                      message: "Попробовать еще раз?",
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Повторить",
                                        style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.showLargeImage(url: self.imageUrl!)
            alert.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Не надо",
                                         style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
}

extension SingleImageViewController {
    private func addViews() {
        view.addSubview(singleImageView.scrollView)
        singleImageView.scrollView.addSubview(singleImageView.singleImageView)
        view.addSubview(singleImageView.backButton)
        view.addSubview(singleImageView.shareButton)
        singleImageView.backButton.addTarget(self, action: #selector(backToFeed), for: .touchUpInside)
        singleImageView.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        addConstraints()
    }

    private func addConstraints() {
        singleImageView.scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        singleImageView.singleImageView.snp.makeConstraints { make in
            make.top.equalTo(singleImageView.scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(singleImageView.scrollView.contentLayoutGuide.snp.bottom)
            make.leading.equalTo(singleImageView.scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(singleImageView.scrollView.contentLayoutGuide.snp.trailing)
        }
        
        singleImageView.backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(9)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(9)
        }
        
        singleImageView.shareButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(36)
        }
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        singleImageView.singleImageView
    }
}

