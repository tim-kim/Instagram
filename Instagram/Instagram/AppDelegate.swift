//
//  AppDelegate.swift
//  Instagram
//
//  Created by Tim Kim on 3/12/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard : UIStoryboard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "timkim321"
                configuration.server = "https://fathomless-earth-13553.herokuapp.com/parse"
            })
        )
        
        // check if user is logged in.
//        storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        if PFUser.current() != nil {
//            
//            // load tab bar controller
//            let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
//            
//            // initialize a new navigation controller with the tab bar controller as its rootViewController
//            let navC = UINavigationController(rootViewController: tabBarController!)
//            
//            // set the window's root view controller to be your new navigation controller
//            self.window?.rootViewController = navC
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

