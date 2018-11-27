//
//  ViewController.swift
//  iOSCodingPractice
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {

    let emailTextField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Please enter email id"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let submitButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        addAutolayoutConstraints()
    }
    
    
    func addAutolayoutConstraints(){
        [emailTextField, submitButton].forEach({ view.addSubview($0) })
        
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    
    @objc func submitButtonTapped(){
        
        guard emailTextField.text != nil else { return }
        
        if (emailTextField.text?.count)! > 0 {
            if  isValidEmail(testStr: emailTextField.text!) {
                
                let nextVC = ShowUserDetailsVC()
                nextVC.emailId = emailTextField.text
                navigationController?.pushViewController(nextVC, animated: true)
                
                emailTextField.text = ""
            }
            else {
                showValidationAlert(message: "Please enter a valid email id",presentVc : self) {
                }
            }
        }else{
            showValidationAlert(message: "Please enter email id",presentVc : self) {
            }
        }
        
    }
    
}


