//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel {
    
    let inputSelectedDate: Observable<Date> = Observable(Date())
    let inputSearchButtonTapped: Observable<Void?> = Observable(nil)
    
    // 변환한 날짜를 내보낼 객체
    let outputSelectDate: Observable<String> = Observable("")
    
    let outputBoxOffice: Observable<[Movie]> = Observable([])
    
    // VM과 VC 사이를 왔다갔다 하는 애가 아님
    private var query = ""
     
    init() {
        print("BoxOfficeViewModel Init")
         
        inputSelectedDate.bind { date in
            print("inputSelectedDate bind")
            self.convertDate(date: date)
        }
        
        inputSearchButtonTapped.bind { _ in
            self.callBoxOffice(date: self.query)
            print("=====", self.query)
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
        
        let format2 = DateFormatter()
        format2.dateFormat = "yyyyMMdd"
        let query = format2.string(from: date)
        self.query = query
    }
    
    private func callBoxOffice(date: String) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kobisAPIKey)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
                dump(success.boxOfficeResult.dailyBoxOfficeList)
                self.outputBoxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
