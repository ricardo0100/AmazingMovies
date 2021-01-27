//
//  AppDelegate.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MainCollectionViewController.newInstance()
        window?.makeKeyAndVisible()
        APIManagerImplementation().fetchGenres(completion: { genres in
            GenresCache.update(with: genres)
        }, onError: nil)
        return true
    }

}
