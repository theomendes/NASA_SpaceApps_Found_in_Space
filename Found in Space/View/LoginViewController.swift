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
        presenter.setupBtnActions()
    }
    
    func performLogin(_ sender: UIButton!) {
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Analytics.setScreenName("Home View Controller", screenClass: "HomeViewController")
    }

}
