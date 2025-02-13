//
//  NotificationViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/13/25.
//

import UIKit
import SnapKit

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
        content.title = "이것이 바로 로컬알림"
        content.subtitle = "서브타이틀 영역"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "woo", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error ?? "에러없음")
        }
    }
}
