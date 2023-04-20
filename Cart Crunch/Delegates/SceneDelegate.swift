//
//  SceneDelegate.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
            // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
            // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let windowScene = (scene as? UIWindowScene) {
            
            //create the UITabBarController
            let tabBarController = UITabBarController()
            
            //create tab bar items
            let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
            let settingsItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
            let storeLocatorItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "mappin.and.ellipse"), selectedImage: UIImage(systemName: "mappin.and.ellipse"))
            
            //make viewcontroller/navigationcontroller for each screen here
            let landingPageVC = LandingPageViewController()
            let logInScreenVC = LogInViewController()
            let signUpScreenVC = SignUpViewController()
            let navigationControllerLandingPage = UINavigationController(rootViewController: landingPageVC)
            
            let homeScreenVC = HomeScreenViewController()
            let navigationControllerHome = UINavigationController(rootViewController: homeScreenVC)
            
            let settingsScreenVC = SettingsViewController()
            let navigationControllerSettings = UINavigationController(rootViewController: settingsScreenVC)
            
            let storeLocatorVC = StoreLocatorViewController()
            let navigationControllerStoreLocator = UINavigationController(rootViewController: storeLocatorVC)
            
           //add the navigationcontrollers to the tab bar
            tabBarController.viewControllers = [
                navigationControllerHome,
                navigationControllerStoreLocator,
                navigationControllerSettings
            ]
            
            //initialize here
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationControllerLandingPage
            self.window = window
            window.makeKeyAndVisible()
            
            //handle tab bar appearance here
            tabBarController.tabBar.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
            
            //handle navigation appearance here
            
            //attach the navigation controllers to the tab bar items
            navigationControllerHome.tabBarItem = homeItem
            navigationControllerSettings.tabBarItem = settingsItem
            navigationControllerStoreLocator.tabBarItem = storeLocatorItem
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        
            // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

