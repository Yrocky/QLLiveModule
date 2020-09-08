//
//  AppDelegate.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .red
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = ViewController()
        return true
    }

}

