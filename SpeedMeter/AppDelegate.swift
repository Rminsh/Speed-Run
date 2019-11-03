//
//  AppDelegate.swift
//  Speed Run
//
//  Created by armin on 5/12/19.
//  Copyright © 2019 Armin Shalchian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let defaults: UserDefaults = UserDefaults.standard
        if !defaults.bool(forKey: SettingsKeys.isNotFirstRun) {
            defaults.set(true, forKey: SettingsKeys.isNotFirstRun)
            defaults.set(false, forKey: SettingsKeys.speedWarningKey)
            defaults.set("2", forKey: SettingsKeys.speedLimitKey)
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "speed_limiter")
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
