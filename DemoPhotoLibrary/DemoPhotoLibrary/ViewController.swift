//
//  ViewController.swift
//  DemoPhotoLibrary
//
//  Created by huy on 15/01/2019.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

protocol DeletePhotoDelegate: class {
    func delete(at indexPath: IndexPath)
}

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var photoPicked: UIImage?
    var indexPath: IndexPath!
    
    weak var delegate: DeletePhotoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if photoPicked != nil {
            imageView.image = photoPicked
        }
    }
    
    @IBAction func DeletePhoto(_ sender: Any) {
        if indexPath != nil {
            delegate?.delete(at: indexPath)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
}

