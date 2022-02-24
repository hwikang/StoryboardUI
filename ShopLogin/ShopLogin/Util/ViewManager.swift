//
//  ViewManager.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import UIKit


struct ViewManager{
    static func getViewController( storyboardName: String,identifier: String) ->UIViewController{
        let storyboard = UIStoryboard(
            name: storyboardName,
            bundle: nil
        )

        let viewController = storyboard.instantiateViewController(
            withIdentifier: identifier
        )
        return viewController
    }
}
