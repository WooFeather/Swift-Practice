//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation

class BoxOfficeViewModel {
    
    let inputSelectedDate: Observable<Date> = Observable(Date())
    
    // 변환한 날짜를 내보낼 객체
    let outputSelectDate: Observable<String> = Observable("")
    
    let outputBoxOffice = [Movie(rank: "10", movieNm: "테스트", audiCnt: "123")]
     
    init() {
        print("BoxOfficeViewModel Init")
         
        inputSelectedDate.bind { date in
            print("inputSelectedDate bind")
            self.convertDate(date: date)
        }
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    private func convertDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let string = format.string(from: date)
        outputSelectDate.value = string
    }
}
