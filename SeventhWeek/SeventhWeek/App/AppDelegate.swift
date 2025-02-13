//
//  AppDelegate.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/3/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Notification 1. 알림 권한 설정
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            print(success, error)
        }
        
        // Notification 2. 포그라운드 수신을 위한 Delegate 설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Notification 2. 포그라운드 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 포그라운드에서의 옵션
        completionHandler([.banner, .badge, .list])
    }
    
    // 알림을 사용자가 클릭했는지 알 수 있는 메서드
    // ex. 카카오톡 특정 채팅방으로 이동, 쿠팡 해당 상품 페이지로 이동
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        print(response.notification.request.content.title) // Identifier 의미 확인해보기
        print(response.notification.request.content.subtitle) // 5199
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.userInfo["type"] as? Int)
    }
}
