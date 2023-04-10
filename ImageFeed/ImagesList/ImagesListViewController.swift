//
//  ViewController.swift
//  ImageFeed
//
//  Created by Dmitry Medvedev on 17.02.2023.
//

import UIKit

final class ImagesListViewController: UIViewController {
    
    private let tableView1 = UITableView()
    
    //@IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    //private let showSingleImageSegueIdentifier = "ShowSingleImage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView1)
        tableView1.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        tableView1.backgroundColor = .ypBlack
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(ImagesListCell.self, forCellReuseIdentifier: "ImagesListCell")
        tableView1.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
//    private func setupTableView() {
//        view.addSubview(tableView1)
//        tableView1.snp.makeConstraints { make in
//            make.top.bottom.leading.trailing.equalToSuperview()
//        }
//        tableView1.delegate = self
//        tableView1.dataSource = self
//        tableView1.register(ImagesListCell.self, forCellReuseIdentifier: "ImagesListCell")
//    }
    
    private func switchToSingleViewController(sender: Any?) {
        let singleImageViewController = SingleImageViewController()
        guard let indexPath = sender as? IndexPath else { return }
        let image = UIImage(named: photosName[indexPath.row])
        singleImageViewController.image = image
        singleImageViewController.modalPresentationStyle = .fullScreen
        present(singleImageViewController, animated: true)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let singleImageViewController = SingleImageViewController()
//        if segue.identifier == showSingleImageSegueIdentifier {
//            //guard let viewController = segue.destination as? SingleImageViewController else { return }
//            guard let indexPath = sender as? IndexPath else { return }
//            let image = UIImage(named: photosName[indexPath.row])
//            singleImageViewController.image = image
//            //viewController.image = image
//        } else {
//            super.prepare(for: segue, sender: sender)
//        }
//    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let photoIndex = photosName[indexPath.row]
        let image = UIImage(named: photoIndex)
        
        guard let photo = image else { return }
        cell.cellImage.image = photo
        cell.dateLabel.text = Date().currentDate
        
        if indexPath.row % 2 == 0 {
            cell.likeButton.imageView?.image = UIImage(named: "Active")
        } else {
            cell.likeButton.imageView?.image = UIImage(named: "No Active")
        }
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchToSingleViewController(sender: indexPath)
        //performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesListCell", for: indexPath)
        
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

