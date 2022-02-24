//
//  UserDefaultsManager.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/24.
//

import Foundation

class UserDefaultManager{
    static func saveAutoLoginAgreement(){
        UserDefaults.standard.set(true,forKey: "autoLoginAgreement")
    }
    static func getAutoLoginAgreement() ->Bool{
        return UserDefaults.standard.bool(forKey: "autoLoginAgreement")
    }
}
