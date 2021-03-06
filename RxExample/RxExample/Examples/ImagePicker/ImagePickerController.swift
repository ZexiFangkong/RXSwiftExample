//
//  ImagePickerController.swift
//  RxExample
//
//  Created by Segii Shulga on 1/5/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePickerController: ViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    @IBOutlet var cropButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        cameraButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        galleryButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        cropButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.editedImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
}
