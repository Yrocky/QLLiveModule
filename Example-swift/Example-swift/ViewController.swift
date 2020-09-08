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
        
        module.setup(
            viewController: self,
            collectionView: collectionView
        )
        module.refresh()
    }
}

