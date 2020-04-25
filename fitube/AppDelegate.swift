//
//  AppDelegate.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/12.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dic = ["timeRemaining":600.0]
        UserDefaults.standard.register(defaults: dic)
        let dic2 = ["currentExercise":1]
        UserDefaults.standard.register(defaults: dic2)
        
//        let isRegistered = UserDefaults.standard.bool(forKey: "ALLREADY_REGISTER")
//               if isRegistered == true{
//                   // implement home view controller
//                   let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ADviceVC") as! AdviceViewController
//                if #available(iOS 13.0, *) {
//                    self.window?.rootViewController = homeViewController
//                } else {
//                    // Fallback on earlier versions
//                }
//                   self.window?.makeKeyAndVisible()
//               }else{
//                   // implement register view controller
//                   let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewVC") as! PageViewController
//                   self.window?.rootViewController = registerViewController
//                   self.window?.makeKeyAndVisible()
//               }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }
        // MARK: - Core Data stack

        lazy var persistentContainer: NSPersistentContainer = {
           
            let container = NSPersistentContainer(name: "Users1")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        // MARK: - Core Data Saving support

        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

}
