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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let module = QLLiveModule(name: "swift")
        module.dataSource.addComponent(QLLiveComponent())
        
        let layout = QLLiveFlexLayout()
        layout.justifyContent = .spaceBetween
        
        let listLayout = QLLiveListLayout()
        listLayout.distribution = .distribution(2)
        listLayout.itemRatio = .itemRatio(1.2)
    

    }


}

