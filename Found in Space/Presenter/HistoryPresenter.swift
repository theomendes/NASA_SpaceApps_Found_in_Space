//
//  HistoryPresenter.swift
//  Found in Space
//
//  Created by Theo Mendes on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit

@objc protocol HistoryView {
    @objc func goToLevel(_ sender: UIButton!)
}

protocol HistoryViewPresenter: HistoryView {}

class HistoryPresenter: HistoryViewPresenter {
    var view: HistoryView
    required init(view: HistoryView) {
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    static var images = ["1","2","3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = .gray
        pc.backgroundColor = .clear
        pc.numberOfPages = HistoryPresenter.images.count
        return pc
    }()
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        return sv
    }()
    
    var arrowRight: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor.white
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "arrowRight"), for: .normal)
        return button
    }()
    
    func setupView(viewC: HistoryViewController){
        scrollView.frame = CGRect(x: 0, y: 0, width: viewC.view.frame.width, height: viewC.view.frame.height)
        arrowRight.alpha = 0.0
        viewC.view.addSubview(scrollView)
        viewC.view.addSubview(pageControl)
        viewC.view.addSubview(arrowRight)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: viewC.view.bottomAnchor),
            pageControl.leftAnchor.constraint(equalTo: viewC.view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: viewC.view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            scrollView.bottomAnchor.constraint(equalTo: viewC.view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: viewC.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: viewC.view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: viewC.view.topAnchor)
        ])
        
        arrowRight.rightAnchor.constraint(equalTo: viewC.view.rightAnchor, constant: -20.0).isActive = true
        arrowRight.bottomAnchor.constraint(equalTo: viewC.view.bottomAnchor, constant: -14).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 80).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 51.0).isActive = true
    }
    
    func setupFrame(){
        for index in 0..<HistoryPresenter.images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: HistoryPresenter.images[index])
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(HistoryPresenter.images.count)), height: scrollView.frame.height)
    }
    
    func setupBtnActions() {
        arrowRight.addTarget(self, action: #selector(goToLevel(_:)), for: .touchUpInside)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func goToLevel(_ sender: UIButton!) {
        view.goToLevel(sender)
    }
}
