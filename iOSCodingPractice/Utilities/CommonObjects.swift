//
//  CommonObjects.swift
//  iOSCodingPractice
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit


class MyBetterAlertController : UIAlertController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}


public func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


public  func showValidationAlert(message : String, presentVc : UIViewController, completion : @escaping () -> Void ) {
    
    let alertVc = MyBetterAlertController.init(title: "", message: message, preferredStyle: .alert)
    alertVc.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
        completion()
    }))
    
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.left
    
    let messageText = NSMutableAttributedString(
        string: message,
        attributes: [
            
            .font: UIFont.boldSystemFont(ofSize: 13)
        ]
    )
    
    alertVc.setValue(messageText, forKey: "attributedMessage")
    
    presentVc.present(alertVc, animated: true, completion: {
        
        
    })
}


