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
            //initialize here
            let landingPageVC = LandingPageViewController()
            let navigationControllerLandingPage = UINavigationController(rootViewController: landingPageVC)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationControllerLandingPage
            self.window = window
            window.makeKeyAndVisible()
            
            //adding the login functionality via notification center
            NotificationCenter.default.addObserver(forName: Notification.Name("login"), object: nil, queue: OperationQueue.main) {[weak self] _ in
                self?.login()
            }
            
            //adding the logout functionality via notification center
            NotificationCenter.default.addObserver(forName: Notification.Name("logout"), object: nil, queue: OperationQueue.main) {[weak self] _ in
                self?.logOut()
            }
            
            //check if current user exsists for persistent login
            if User.current != nil {
                login()
            }
        }
    }
    
    private func login() {
        //send the user to the tab bar controller
        //create the UITabBarController
        let tabBarController = UITabBarController()
        
        //create tab bar items
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        let settingsItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        let storeLocatorItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "mappin.and.ellipse"), selectedImage: UIImage(systemName: "mappin.and.ellipse"))
        
        //make viewcontroller/navigationcontroller for each screen here
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
        
        //handle tab bar appearance here
        tabBarController.tabBar.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0)
        
        //handle navigation appearance here
        
        //attach the navigation controllers to the tab bar items
        navigationControllerHome.tabBarItem = homeItem
        navigationControllerSettings.tabBarItem = settingsItem
        navigationControllerStoreLocator.tabBarItem = storeLocatorItem
        
        window?.rootViewController = tabBarController
    }
    
    private func logOut() {
        //Log out the parse user
        //this will remove the user from the sessions and all future calls will return nill
        User.logout { [weak self] result in
            
            switch result{
            case .success:
                //make sure that UI updates are done on main thread when initiad from background thread
                DispatchQueue.main.async {
                    //go back to the login page
                    let landingPageVC = LandingPageViewController()
                    //wrap the view controller in a navigation controller
                    let navigationControllerLandingPage = UINavigationController(rootViewController: landingPageVC)
                    //set the current displayed view controller
                    self?.window?.rootViewController = navigationControllerLandingPage
                }
            case .failure(let error):
                print("Log out error: \(error)")
            }
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

