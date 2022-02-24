//
//  UIImage.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import UIKit

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage? {
       let scale = newWidth / self.size.width
       let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { print("Image resize error"); return nil}
       UIGraphicsEndImageContext()

       return newImage
   }
  
}
