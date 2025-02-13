//
//  SceneDelegate.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = UINavigationController(rootViewController: NotificationViewController())
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Badge 제거
        // iOS 17 이전
        // UIApplication.shared.applicationIconBadgeNumber = 0
        
        // 이시점에 badgeCount를 다시 설정할 수 있음
        UNUserNotificationCenter.current().setBadgeCount(0)
        
        // 사용자에게 전달되어 있는 알람 제거
        // UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        // 사용자에게 아직 전달되지 않았지만, 앞으로 전달될 알람을 제거
        // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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

