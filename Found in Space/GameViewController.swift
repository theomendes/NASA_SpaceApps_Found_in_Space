//
//  ViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var skview: SKView?
    var gameView: UIView?
    let levelsData = DataAccess.object.loadLevels()
    var level: Level!
    var pauseController: PauseViewController?
    
    var pauseButton: UIButton = {
        var button = UIButton(type: UIButton.ButtonType.custom)
        let pauseImage = UIImage(named: "pauseButton")
        button.backgroundColor = .clear
        button.setImage(pauseImage, for: .normal)
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.skview = SKView(frame: self.view.bounds)
        self.view.addSubview(skview!)
        self.view.addSubview(pauseButton)
        pauseButton.isHidden = true
        
        if let view = skview {
            level = Level(from: levelsData[0], in: self.view)
            level.controller = self
            view.presentScene(level)
            
            view.ignoresSiblingOrder = true
//            view.showsFields = true
//            view.showsPhysics = true
            setNeedsFocusUpdate()
        }
        setPauseButtonConstraints()
    }
    
    @objc func pause() {
        if level.pause() {
            pauseController = PauseViewController()
            pauseController!.gameController = self
            addChild(pauseController!)
            pauseController!.view.frame = view.frame
            view.addSubview(pauseController!.view)
            setPauseViewConstraints()
            pauseController!.didMove(toParent: self)
        }
    }
    
    func play() {
        guard
            pauseController != nil,
            level.isGamePaused else { return }
        
        level.play()
        
        pauseController!.willMove(toParent: nil)
        pauseController!.view.removeConstraints(pauseController!.view.constraints)
        pauseController!.view.removeFromSuperview()
        pauseController!.removeFromParent()
        pauseController?.gameController = nil
        
        pauseController = nil
    }
    
    func exit() {
        pauseController?.dismiss(animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setPauseButtonConstraints() {
        if #available(iOS 11.0, *) {
            pauseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            pauseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        } else {
            pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            pauseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        }
        pauseButton.widthAnchor.constraint(equalToConstant: 51.47).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 19.5).isActive = true
    }
    
    func setPauseViewConstraints() {
        guard let pauseController = pauseController else { return }
        NSLayoutConstraint.activate([
            pauseController.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            pauseController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pauseController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
    }

}
