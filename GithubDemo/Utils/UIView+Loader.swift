//
//  UIView+Loader.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import UIKit

//MARK:- Show loader for UIVIEW
extension UIView{
    func showLoader(){
        self.isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tag = 12345
        activityIndicator.frame = CGRect(x: self.frame.origin.x + self.frame.size.width/2,y: self.frame.origin.y +  self.frame.size.height/2, width: 26, height: 26)
        self.addSubview(activityIndicator)
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
    }

    func hideLoader(){
        self.isUserInteractionEnabled = true
        if let  activityIndicator = self.viewWithTag(12345) as? UIActivityIndicatorView{
            activityIndicator.removeFromSuperview()
        }
    }
}
