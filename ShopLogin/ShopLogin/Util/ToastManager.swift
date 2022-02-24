//
//  ToastManager.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/24.
//

import UIKit

class ToastMessageManager {
    static func showToast(message : String) {
        if let topController = getTopViewController() {
            let toastLabel = UILabel()
          
            setText(toastLabel: toastLabel, message: message)
            
            setFrame(topViewController:topController,toastLabel:toastLabel)
            
            setDesign(toastLabel: toastLabel)
            
            topController.view.addSubview(toastLabel)
            UIView.animate(withDuration: 2.5, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
       
    }
    static private func setText(toastLabel: UILabel, message : String) {
//        toastLabel.setFont(fontWeight: .regular, fontSize: 14)
        toastLabel.font = UIFont(name: "System", size: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
    }
    
    static private func setFrame(topViewController: UIViewController , toastLabel:UILabel) {
        
        let width = toastLabel.intrinsicContentSize.width + 40
        let xPosition = topViewController.view.bounds.width / 2 - width / 2
        let yPosition = topViewController.view.bounds.height - 100
        
        toastLabel.frame = CGRect(x: xPosition, y: yPosition, width: width, height: toastLabel.intrinsicContentSize.height)
    }
    
    static private func setDesign(toastLabel: UILabel) {
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
    }
    
    
    private static func getTopViewController() -> UIViewController?{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController{
            while let presendtedViewController = topController.presentedViewController {
                topController = presendtedViewController
            }
            return topController
        }else {
            return nil
        }
    }
}
