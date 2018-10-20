//
//  HomePresenter.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

@objc protocol HomeView {
    @objc func goToNewGame(_ sender: UIButton!)
    @objc func goToProfile(_ sender: UIButton!)
}

protocol HomeViewPresenter: HomeView {}

class HomePresenter: HomeViewPresenter {
    
    var view: HomeView
    required init(view: HomeView) {
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Declaration of UI Elements
    var newGameBtn: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor.white
        button.setTitle(
            NSLocalizedString("home-new-game", comment: "Button: New Game"),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var profileBtn: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor.white
        button.setTitle(NSLocalizedString("home-profile", comment: "Button: Profile"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /**
     Setup the Controller UI
     
     - parameter vc: Current ViewController
    */
    func setUpHomeView(viewC: HomeViewController) {
        
        viewC.view.addSubview(newGameBtn)
        viewC.view.addSubview(profileBtn)
        
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
        newGameBtn.centerXAnchor.constraint(equalTo: viewC.view.centerXAnchor).isActive = true
        newGameBtn.centerYAnchor.constraint(equalTo: viewC.view.centerYAnchor).isActive = true
        
        profileBtn.rightAnchor.constraint(equalTo: safeRightAnchor).isActive = true
        profileBtn.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10).isActive = true
    }
    
    func setupBtnActions() {
        newGameBtn.addTarget(self, action: #selector(goToNewGame(_:)), for: .touchUpInside)
        profileBtn.addTarget(self, action: #selector(goToProfile(_:)), for: .touchUpInside)
    }
    
    func goToNewGame(_ sender: UIButton) {
        view.goToNewGame(sender)
    }
    
    func goToProfile(_ sender: UIButton!) {
        view.goToProfile(sender)
    }
    
}
