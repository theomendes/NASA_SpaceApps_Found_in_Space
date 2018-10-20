//
//  HomeViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeView {

    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        presenter.setUpHomeView(viewC: self)
        presenter.setupBtnActions()
    }
    
    func goToNewGame(_ sender: UIButton!) {
        // Do something
        print("New Game touched")
    }
    
    func goToProfile(_ sender: UIButton!) {
        // do something
        print("Profile touched")
    }

}
