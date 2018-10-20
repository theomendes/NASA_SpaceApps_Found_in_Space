//
//  HomeViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, HomeView {
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        presenter.setUpHomeView(viewC: self)
        presenter.setupBtnActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Analytics.setScreenName("Home View Controller", screenClass: "HomeViewController")
    }
    
    func goToNewGame(_ sender: UIButton!) {
        // Do something
        print("New Game touched")
        let navigationController = UINavigationController(rootViewController: GameViewController())
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func goToProfile(_ sender: UIButton!) {
        // do something
        print("Profile touched")
    }

}
