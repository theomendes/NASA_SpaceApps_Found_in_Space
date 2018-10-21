//
//  HistoryViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UIScrollViewDelegate, HistoryView {
    
    var presenter: HistoryPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = HistoryPresenter(view: self)
        presenter.setupView(viewC: self)
        presenter.setupFrame()
        presenter.setupBtnActions()
        
        presenter.scrollView.delegate = self
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        presenter.pageControl.currentPage = Int(pageNumber)
        if pageNumber == 2 {
            presenter.arrowRight.alpha = 1.0
        } else {
            presenter.arrowRight.alpha = 0.0
        }
    }
    
    func goToLevel(_ sender: UIButton!) {
        print("New Game touched")
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }

}
