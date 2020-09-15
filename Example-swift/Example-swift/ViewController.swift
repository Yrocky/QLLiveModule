//
//  ViewController.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import UIKit
import QLLiveModuler

class ViewController: UIViewController {

    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    let module = DemoResumeModule(name: "Resume")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.backgroundColor = .backgroundColor
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
//        QLLiveLayoutAreas.areas("head")
//        QLLiveLayoutAreas.none()
        let row = QLLiveGridLayoutRow.row(with: 200)
        row.setup([
            .fractional(1),
            .fractional(2),
            .fractional(3)
        ])
        row.setup([
            .absolute(100),
            .auto()
        ])
        row.setupColumn(
            .fractional(1),
            repeat: 3
        )

        let layout = QLLiveGridLayout()
        module.setup(
            viewController: self,
            collectionView: collectionView
        )
        module.refresh()
    }
}

