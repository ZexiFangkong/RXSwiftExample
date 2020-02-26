//
//  SimpleValidationViewModel.swift
//  RxExample-iOS
//
//  Created by Jersey on 2020/2/26.
//  Copyright © 2020 Krunoslav Zaher. All rights reserved.
//

import Foundation
import RxSwift

class SimpleValidationViewModel {

    
    let usernameValid : Observable<Bool>
    let passwrodValid : Observable<Bool>
    let everythingValid: Observable<Bool>
    
    init(username: Observable<String>,
         passwrod: Observable<String>) {
                
        usernameValid = username
        .map { $0.count >= 5 }
        
        .share(replay: 1)

        passwrodValid = passwrod
            .map { $0.count >= 5 }
            .share(replay: 1)

        everythingValid = Observable.combineLatest(usernameValid, passwrodValid) { $0 && $1 }
            .share(replay: 1)
    }
    
    
    
}
