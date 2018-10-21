//
//  LoginPresenter.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_ColorThemer
import MaterialComponents.MaterialTextFields_TypographyThemer

@objc protocol LoginView {
    @objc func performLogin(_ sender: UIButton!)
    @objc func dismiss(_ sender:UIButton!)
    @objc func keyboardWillShow(_ notification: NSNotification)
    @objc func keyboardWillHide(_ notification: NSNotification)
    @objc func didTapTouch(_ sender: UIGestureRecognizer)
}

protocol LoginViewPresenter: LoginView {}

class LoginPresenter: LoginViewPresenter {
    var allTextFieldControllers = [MDCTextInputControllerFilled]()
    static let emailController = MDCTextInputControllerFilled(textInput: LoginPresenter.emailTextField)
    static let passwordController = MDCTextInputControllerFilled(textInput: LoginPresenter.passwordTextField)
    
    let view: LoginView
    required init(view: LoginView) {
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Declaration of UI Elements
    var backgroundImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "homeBackground")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var closeBtn: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor.clear
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return scrollView
    }()
    
    // Create form StackView
    let formStackView: UIStackView = {
        let formStackView = UIStackView()
        formStackView.axis = .vertical
        formStackView.distribution  = .fill
        formStackView.alignment = .center
        formStackView.spacing = 10.0
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        return formStackView
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.text = NSLocalizedString("login-title-label", comment: "Label: Login")
        label.textColor = .white
        label.font = UIFont.homeBtn30
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var emailTextField: MDCTextField = {
        var field = MDCTextField()
        field.autocorrectionType = .no
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.textColor = .white
        field.keyboardAppearance = .dark
        field.clearButtonMode = .unlessEditing
        field.textColor = .white
        field.placeholderLabel.textColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    static var passwordTextField: MDCTextField = {
        var field = MDCTextField()
        field.autocorrectionType = .no
        field.keyboardType = .default
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.textColor = .white
        field.keyboardAppearance = .dark
        field.clearButtonMode = .unlessEditing
        field.textColor = .white
        field.placeholderLabel.textColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var loginBtn: UIButtonWithGradientAndShadow = {
        var button = UIButtonWithGradientAndShadow(
            gradientColors: [
                UIColor.CustomColours.HomeButtoGradient.start,
                UIColor.CustomColours.HomeButtoGradient.end],
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
        button.setTitle(
            NSLocalizedString("login-login-button", comment: "Button: Login"),
            for: .normal
        )
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.homeBtn20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signupBtn: UIButton = {
        var button = UIButton()
        button.setTitle(
            NSLocalizedString("login-signup-button", comment: "Button: Create an account"),
            for: .normal
        )
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.homeBtn12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /**
     Setup the Controller UI
     
     - parameter vc: Current ViewController
     */
    func setUpLoginView(viewC: LoginViewController) {
        allTextFieldControllers.append(LoginPresenter.emailController)
        allTextFieldControllers.append(LoginPresenter.passwordController)
        
        LoginPresenter.emailController.placeholderText = NSLocalizedString(
            "login-email-placeholder", comment: "TextField Placeholder: Password"
        )
        LoginPresenter.emailController.activeColor = .white
        LoginPresenter.emailController.normalColor = .white
        LoginPresenter.emailController.floatingPlaceholderNormalColor = .white
        LoginPresenter.emailController.textInputClearButtonTintColor = .white
        LoginPresenter.emailController.textInputClearButtonTintColor = .white
        LoginPresenter.emailController.leadingUnderlineLabelFont = UIFont.homeBtn12
        LoginPresenter.emailController.floatingPlaceholderActiveColor = .white
        LoginPresenter.emailController.inlinePlaceholderColor = .white
        LoginPresenter.emailController.errorColor = UIColor(hex: "f8e71c")
        
        LoginPresenter.passwordController.placeholderText = NSLocalizedString(
            "login-password-placeholder", comment: "TextField Placeholder: Password"
        )
        LoginPresenter.passwordController.activeColor = .white
        LoginPresenter.passwordController.normalColor = .white
        LoginPresenter.passwordController.floatingPlaceholderNormalColor = .white
        LoginPresenter.passwordController.textInputClearButtonTintColor = .white
        LoginPresenter.passwordController.textInputClearButtonTintColor = .white
        LoginPresenter.passwordController.leadingUnderlineLabelFont = UIFont.homeBtn12
        LoginPresenter.passwordController.floatingPlaceholderActiveColor = .white
        LoginPresenter.passwordController.inlinePlaceholderColor = .white
        LoginPresenter.passwordController.errorColor = UIColor(hex: "f8e71c")
        
        viewC.view.addSubview(backgroundImage)
        viewC.view.addSubview(scrollView)
        viewC.view.addSubview(formStackView)
        viewC.view.addSubview(closeBtn)
        
        // Text Fields
        formStackView.addArrangedSubview(titleLabel)
        formStackView.addArrangedSubview(LoginPresenter.emailTextField)
        formStackView.addArrangedSubview(LoginPresenter.passwordTextField)
        
        formStackView.addArrangedSubview(loginBtn)
        
        formStackView.addArrangedSubview(signupBtn)
        
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
        backgroundImage.topAnchor.constraint(equalTo: viewC.view.topAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: viewC.view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: viewC.view.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: viewC.view.leftAnchor).isActive = true
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["scrollView": scrollView])
        )
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["scrollView": scrollView])
        )
        
        closeBtn.rightAnchor.constraint(equalTo: safeRightAnchor).isActive = true
        closeBtn.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        formStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        formStackView.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10).isActive = true
        formStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: formStackView.widthAnchor).isActive = true
        LoginPresenter.emailTextField.widthAnchor.constraint(equalTo: formStackView.widthAnchor).isActive = true
        LoginPresenter.passwordTextField.widthAnchor.constraint(equalTo: formStackView.widthAnchor).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: formStackView.widthAnchor).isActive = true
        signupBtn.widthAnchor.constraint(equalTo: formStackView.widthAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Keyboard Handling
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(view.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(view.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillChangeFrameNotification"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"),
            object: nil)
    }
    func setupBtnActions() {
        loginBtn.addTarget(self, action: #selector(performLogin(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    
    func setupActions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapTouch))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func performLogin(_ sender: UIButton!) {
        view.performLogin(sender)
    }
    
    func dismiss(_ sender: UIButton!) {
        view.dismiss(sender)
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        view.keyboardWillShow(notification)
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        view.keyboardWillHide(notification)
    }
    
    func didTapTouch(_ sender: UIGestureRecognizer) {
        view.didTapTouch(sender)
    }
    
}
