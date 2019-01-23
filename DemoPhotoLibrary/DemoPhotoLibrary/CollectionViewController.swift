//
//  CollectionViewController.swift
//  DemoPhotoLibrary
//
//  Created by huy on 15/01/2019.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos: [Images] = []
    var selectedPhoto: UIImage?
    var isButtonHidden: Bool = true
    let WIDTH_SCREEN = UIScreen.main.bounds.width
    let numberOfItems: CGFloat = 4
    let padding: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            if let collectionView = self.collectionView,
                let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                viewController.photoPicked = cell.imageView.image
                viewController.indexPath = cell.indexPath
                viewController.delegate = self
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.count == 0 {
            return 0
        } else {
            return photos.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = photos[indexPath.row].photo
        cell.indexPath = indexPath
        return cell
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Xcode 10
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//        let chosenPhoto = Images(photo: selectedImage)
//
//        photos += [chosenPhoto]
//        collectionView?.reloadData()
//        dismiss(animated: true, completion: nil)
//    }
    
    //Xcode 9
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let chosenPhoto = Images(photo: selectedImage)
        
        photos += [chosenPhoto]
        collectionView?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func PickingPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    //    kích thước của item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (WIDTH_SCREEN - padding * 2 - padding * (numberOfItems - 1))/numberOfItems
        return CGSize(width: itemSize, height: itemSize)
    }
    
    //    khoảng cách giữa mỗi cạnh của section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
    }
    
    //    khoảng cách giữa các dòng section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    //    khoảng cách giữa các cột section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}

extension CollectionViewController: DeletePhotoDelegate {
    func delete(at indexPath: IndexPath) {
        photos.remove(at: indexPath.row)
        collectionView?.reloadData()
    }
}
