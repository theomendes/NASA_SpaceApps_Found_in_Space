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
    var newGameBtn: UIButtonWithGradientAndShadow = {
        var button = UIButtonWithGradientAndShadow(
            gradientColors: [
                UIColor.CustomColours.HomeButtoGradient.start,
                UIColor.CustomColours.HomeButtoGradient.end],
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
        button.setTitle(
            NSLocalizedString("home-new-game", comment: "Button: New Game"),
            for: .normal
        )
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.homeBtn20
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
    
    var backgroundImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "homeBackground")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var appLogo: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "appLogo")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /**
     Setup the Controller UI
     
     - parameter vc: Current ViewController
    */
    func setUpHomeView(viewC: HomeViewController) {
        viewC.view.addSubview(backgroundImage)
        viewC.view.addSubview(appLogo)
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
        
        var safeBottomAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, *) {
                return viewC.view.safeAreaLayoutGuide.bottomAnchor
            } else {
                return viewC.view.topAnchor
            }
        }
        
        // MARK: - Constraints
        newGameBtn.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: -35.0).isActive = true
        newGameBtn.centerXAnchor.constraint(equalTo: viewC.view.centerXAnchor).isActive = true
        newGameBtn.widthAnchor.constraint(equalToConstant: 175.0).isActive = true
        newGameBtn.heightAnchor.constraint(equalToConstant: 57.0).isActive = true
        
        profileBtn.rightAnchor.constraint(equalTo: safeRightAnchor).isActive = true
        profileBtn.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10).isActive = true
        
        backgroundImage.topAnchor.constraint(equalTo: viewC.view.topAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: viewC.view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: viewC.view.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: viewC.view.leftAnchor).isActive = true
        
        appLogo.centerXAnchor.constraint(equalTo: viewC.view.centerXAnchor).isActive = true
        appLogo.topAnchor.constraint(equalTo: viewC.view.topAnchor, constant: 75).isActive = true
        appLogo.widthAnchor.constraint(equalToConstant: 317).isActive = true
        appLogo.heightAnchor.constraint(equalToConstant: 154.69).isActive = true
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
