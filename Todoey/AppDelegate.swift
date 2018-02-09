//
//  AppDelegate.swift
//  Todoey
//
//  Created by Shuntian Li on 2018-01-23.
//  Copyright © 2018 Shuntian Li. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        do{
            
           _ = try Realm()
            
        } catch {
            
            print("Error Creating New Realm. \(error)")
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
        
    }
    



}

