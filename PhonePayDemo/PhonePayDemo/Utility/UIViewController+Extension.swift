//
//  UIViewController+Extension.swift
//  PhonePayDemo
//
//  Created by Devaki Nandan Sharma on 25/11/23.
//

import UIKit

extension UIViewController {
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait fetching venue...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader() {
        dismiss(animated: false, completion: nil)
    }
}
