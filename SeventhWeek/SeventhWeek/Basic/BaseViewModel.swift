//
//  BaseViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/10/25.
//

import Foundation

// generic: 타입 파라미터를 통해 호출 시 타입이 결정
//func plus<T: Numeric>(a: T, b: T) -> T {
//    return a + b
//}

protocol BaseViewModel { // 인터페이스
    associatedtype Input
    associatedtype Output
    func transform()
}

protocol Mentor {
    associatedtype Jack
    
    func hello(a: Jack)
}

class Test: Mentor {
    typealias Jack = String
    
    func hello(a: Jack) {
        print(a)
    }
}

// 구체적으로 명세할 경우 typealias 필요 X
// 구체적으로 명세하지 않는다면 typealias로 별칭 설정
//class Sample: BaseViewModel {
//    
//    struct Input {
//        
//    }
//    
//    struct Output {
//        
//    }
//    
//    func transform() {
//        <#code#>
//    }
//}
