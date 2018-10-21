//
//  PauseViewController.swift
//  Found in Space
//
//  Created by pedro ferraz on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var blurView: UIVisualEffectView!
    
    weak var gameController: GameViewController?
    
    var resumeBtn: UIButtonWithGradientAndShadow = {
        var button = UIButtonWithGradientAndShadow(
            gradientColors: [
                UIColor.CustomColours.HomeButtoGradient.start,
                UIColor.CustomColours.HomeButtoGradient.end],
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
        button.setTitle(
            NSLocalizedString("resume-game", comment: "Button: Resume"),
            for: .normal
        )
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.homeBtn20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var exitBtn: UIButtonWithGradientAndShadow = {
        var button = UIButtonWithGradientAndShadow(
            gradientColors: [
                UIColor.CustomColours.HomeButtoGradient.start,
                UIColor.CustomColours.HomeButtoGradient.end],
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
        button.setTitle(
            NSLocalizedString("exit-game", comment: "Button: Exit"),
            for: .normal
        )
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.homeBtn20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func play() {
        gameController?.play()
    }
    
    @objc func exit() {
        gameController?.exit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        view.addSubview(resumeBtn)
        view.addSubview(exitBtn)
        //        setPlayButtonConstraints()
        //        setExitButtonConstraints()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        blurView = UIVisualEffectView(effect: blurEffect)
        
        view.insertSubview(blurView, at: 0)
        
        //        setUpBlurViewConstraints()
    }
    
    private func setUpBlurViewConstraints() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    //    private func setPlayButtonConstraints() {
    //        NSLayoutConstraint.activate([
    //            playButton.heightAnchor.constraint(equalToConstant: 68),
    //            playButton.widthAnchor.constraint(equalToConstant: 292),
    //            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            playButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
    //            ])
    //    }
    //
    //    private func setExitButtonConstraints() {
    //        NSLayoutConstraint.activate([
    //            exitButton.heightAnchor.constraint(equalToConstant: 68),
    //            exitButton.widthAnchor.constraint(equalToConstant: 292),
    //            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    //            exitButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20)
    //            ])
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

import Foundation
