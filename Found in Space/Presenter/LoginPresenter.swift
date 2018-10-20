//
//  LoginPresenter.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

@objc protocol LoginView {
    @objc func performLogin(_ sender: UIButton!)
}

protocol LoginViewPresenter: LoginView {}

class LoginPresenter: LoginViewPresenter {
    
    var view: LoginView
    required init(view: LoginView) {
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Declaration of UI Elements
    var emailInput: UITextField = {
        var input = UITextField()
        input.placeholder = NSLocalizedString(
            "login-email-placeholder",
            comment: "Text Field: E-mail"
        )
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
        input.keyboardType = .emailAddress
        input.keyboardAppearance = .dark
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var pwdInput: UITextField = {
        var input = UITextField()
        input.placeholder = NSLocalizedString(
            "login-password-placeholder",
            comment: "Text Field: Password"
        )
        input.autocapitalizationType = .none
        input.autocorrectionType = .no
        input.keyboardType = .default
        input.keyboardAppearance = .dark
        input.isSecureTextEntry = true
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var loginBtn: UIButton = {
        var button = UIButton()
        button.setTitle(
            NSLocalizedString("login-login-placeholder", comment: "Button: Login"),
            for: .normal
        )
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var loginStackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 30
        view.alignment = .center
        return view
    }()
    
    /**
     Setup the Controller UI
     
     - parameter vc: Current ViewController
     */
    func setUpLoginView(viewC: LoginViewController) {
        
        viewC.view.backgroundColor = UIColor.white
        
        viewC.view.addSubview(loginStackView)
        
        loginStackView.addArrangedSubview(emailInput)
        loginStackView.addArrangedSubview(pwdInput)
        loginStackView.addArrangedSubview(loginBtn)
        
        // MARK: - Setup Safe Margins
        var safeTopAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, *) {
                return viewC.view.safeAreaLayoutGuide.topAnchor
            } else {
                return viewC.view.topAnchor
            }
        }
        
        var safeLeftAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return viewC.view.safeAreaLayoutGuide.leftAnchor
            } else {
                return viewC.view.leftAnchor
            }
        }
        
        var safeRightAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return viewC.view.safeAreaLayoutGuide.rightAnchor
            } else {
                return viewC.view.rightAnchor
            }
        }
        
        // MARK: - Constraints
        loginStackView.centerXAnchor.constraint(equalTo: viewC.view.centerXAnchor).isActive = true
        loginStackView.centerYAnchor.constraint(equalTo: viewC.view.centerYAnchor).isActive = true
        loginStackView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        
        emailInput.leftAnchor.constraint(equalTo: loginStackView.leftAnchor).isActive = true
        emailInput.rightAnchor.constraint(equalTo: loginStackView.rightAnchor).isActive = true
        
        pwdInput.leftAnchor.constraint(equalTo: loginStackView.leftAnchor).isActive = true
        pwdInput.rightAnchor.constraint(equalTo: loginStackView.rightAnchor).isActive = true
        
        loginBtn.leftAnchor.constraint(equalTo: loginStackView.leftAnchor).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: loginStackView.rightAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    func setupBtnActions() {
        loginBtn.addTarget(self, action: #selector(performLogin(_:)), for: .touchUpInside)
    }
    
    func performLogin(_ sender: UIButton!) {
        //
    }
    
}
