//
//  HomeViewController.swift
//  Onboarding Guide
//
//  Created by Scott Clampet on 9/2/19.
//  Copyright © 2019 Scott Clampet. All rights reserved.
//

import UIKit

private let cellId = "cellId"
private let pages: [Page] = {
    return [
        Page(imageName: "page1", title: "Choose your adventure", bodyText: "We're here to help you make the most of the adventures that matter to you."),
        Page(imageName: "page2", title: "Document your experience", bodyText: "We'll help make sure you never forget this."),
        Page(imageName: "page3", title: "Bask in the glow", bodyText: "Relax and reminisce about what a great decision you've made.")
    ]
}()

class HomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .cyan
        pc.numberOfPages = 3
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupScrolling()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        view.addConstraintsWithFormat(format: "V:[v0(100)]|", views: pageControl)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: pageControl)
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupScrolling() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    // MARK: Delagate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
