//
//  LoginViewModel.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import Foundation
import RxSwift

class LoginViewModel{
    private let loginSubject = BehaviorSubject<LoginState>(value: .none)
    
    func setLoginState(state:LoginState){
        loginSubject.onNext(state)
    }
    
    func getLoginObserver() -> Observable<LoginState>{
        return loginSubject.asObservable()
    }
    
    
    func getAutoLoginAgreement() -> Bool {
        return UserDefaultManager.getAutoLoginAgreement()
    }
    
    func setAutoLoginAgreement(){
        UserDefaultManager.saveAutoLoginAgreement()
    }
}
