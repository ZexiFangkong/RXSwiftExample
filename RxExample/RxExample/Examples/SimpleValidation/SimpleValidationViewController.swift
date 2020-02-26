//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//import SimpleValidationViewModel

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController : ViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!

    @IBOutlet weak var doSomethingOutlet: UIButton!
    
//    private var viewModel: SimpleValidationViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewModel: SimpleValidationViewModel

        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        viewModel = SimpleValidationViewModel(
            username: usernameOutlet.rx.text.orEmpty.asObservable(),
            passwrod: passwordOutlet.rx.text.orEmpty.asObservable()
        )
        
        viewModel.usernameValid
            .bind(to: self.usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.usernameValid
            .bind(to: self.passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.passwrodValid
            .bind(to: self.passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.everythingValid
            .bind(to: self.doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alertView.show()
    }

}
