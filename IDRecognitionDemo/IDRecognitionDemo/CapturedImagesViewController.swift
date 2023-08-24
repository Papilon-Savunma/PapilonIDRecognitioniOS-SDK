//
//  CapturedImagesViewController.swift
//  IDRecognitionDemo
//
//  Created by Yasin on 24.08.2023.
//

import UIKit
import Foundation
import PapilonIDRecognitioniOS

class CapturedImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var capturedImages: [PapilonIDRecognitioniOS.IDRecognizer.ImageResult] = []
    
    private var collectionView: UICollectionView!
    
    init(images: [PapilonIDRecognitioniOS.IDRecognizer.ImageResult]) {
        self.capturedImages = images
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Arranging images vertically
        layout.minimumLineSpacing = 20 // Vertical gap between images
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Determining cell size using the original dimensions of the image
           let imageSize = capturedImages[indexPath.item].image.extent.size
           return imageSize
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        let imageResult = capturedImages[indexPath.item]
        cell.imageView.image = UIImage(ciImage: imageResult.image)
        cell.titleLabel.text = imageResult.key
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return capturedImages.count
    }

}

class ImageCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
     var titleLabel: UILabel! // Caption indicating the area to which the image belongs
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         titleLabel = UILabel(frame: .zero)
         titleLabel.textAlignment = .center
         titleLabel.font = UIFont.systemFont(ofSize: 14)
         titleLabel.textColor = .black
         
         imageView = UIImageView(frame: .zero)
         imageView.contentMode = .scaleAspectFit
         

         self.contentView.addSubview(titleLabel)
         self.contentView.addSubview(imageView)
         
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         imageView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
             titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
             titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
             imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
             imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
             imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
             imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
         ])
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
