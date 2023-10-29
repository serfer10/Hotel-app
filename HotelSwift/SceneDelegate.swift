

import UIKit

class TestWindow: UIWindow {
    override func sendEvent(_ event: UIEvent) {

        print(event)

        //<UITouchesEvent: 0x6000008b1f80> timestamp: 366545 touches: {(
        //    <UITouch: 0x7fa056d37dc0> phase: Ended tap count: 1 force: 0.000
        //window: <zollundpost.TestWindow: 0x7fa056c020a0; baseClass = UIWindow;
        //frame = (0 0; 375 812); gestureRecognizers = <NSArray: 0x6000034f9530>;
        //layer = <UIWindowLayer: 0x600003abd940>> view: <UITableViewCellContentView:
        //0x7fa059a55090; frame = (0 0; 375 72); opaque = NO; gestureRecognizers =
        //<NSArray: 0x6000034293e0>; layer = <CALayer: 0x600003ac8320>> location in
        //window: {165, 358.33332824707031} previous location in window:
        //{144.33332824707031, 358.66665649414062} location in view: {165,
        //44.999992370605469} previous location in view: {144.33332824707031,
        //45.333320617675781}
        //    )}

        super.sendEvent(event)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = TestWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Cochin", size: 21)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        let navController = UINavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationController: navController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
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
    }


}

