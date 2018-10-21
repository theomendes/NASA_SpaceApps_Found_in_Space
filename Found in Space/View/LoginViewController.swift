//
//  LoginViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, LoginView {
    
    var presenter: LoginPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = LoginPresenter(view: self)
        presenter.setUpLoginView(viewC: self)
        presenter.setupActions()
        presenter.setupBtnActions()
        
        LoginPresenter.emailTextField.delegate = self
        LoginPresenter.passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Analytics.setScreenName("Home View Controller", screenClass: "HomeViewController")
    }
    
    func performLogin(_ sender: UIButton!) {
        //
        print("Profile touched")
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        // swiftlint:disable next force_cast
        let keyboardFrame =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        presenter.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        presenter.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func didTapTouch(_ sender: UIGestureRecognizer) {
        print("Oh No")
        self.view.endEditing(true)
    }
    
    func dismissView(_ sender: UIButton!) {
        print("Oh No")
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.dismiss(animated: true, completion: nil)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // TextField
        if textField == LoginPresenter.passwordTextField &&
            LoginPresenter.passwordTextField.text != nil &&
            LoginPresenter.passwordTextField.text!.count < 8 {
            LoginPresenter.passwordController.setErrorText("Password is too short",
                                                     errorAccessibilityValue: nil)
        }
        
        return false
    }
}
