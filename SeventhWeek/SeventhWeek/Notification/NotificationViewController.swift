//
//  NotificationViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/13/25.
//

import UIKit
import SnapKit
/*
 Notification 관련 정책
 - Foreground에서는 알림이 뜨지 않는 것이 default
 - Foreground에서 알림을 받고 싶은 경우, 별도 설정(delegate) 필요
 - 반복 기능의 경우 TimeIntervar은 최소 60초를 넘어야 함
 - 알림센터에 알림 스택 기준은 identifier. 각 알림의 고유값을 의미
 - 배지 숫자는 알림 개수와 무관. 일일이 관리 해줘야 함
 */
class NotificationViewController: UIViewController {
    
    let requestButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        configureButton()
    }

    func configureButton() {
        view.addSubview(requestButton)
        requestButton.backgroundColor = .blue
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        requestButton.addTarget(self, action: #selector(requestButtonClocked), for: .touchUpInside)
    }
    
    @objc
    func requestButtonClocked() {
        print(#function)
        
        let content = UNMutableNotificationContent()
        content.title = "Identifier 의미 확인해보기: 동일한 Identifier일 경우"
        content.subtitle = "\(Int.random(in: 1...10000))"
        content.badge = 22
        
        // 1) 시간 간격
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
    
        // 2) 캘린더 기반
        
        //        var components = DateComponents()
        //        components.minute = 18 // n 시 18분마다 반복
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // 3) 위치기반 => 알아서 찾아보기
    
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error ?? "에러없음")
        }
    }
}
