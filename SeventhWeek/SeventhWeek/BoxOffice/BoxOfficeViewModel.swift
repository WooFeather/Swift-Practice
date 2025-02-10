//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let selectedDate: Observable<Date> = Observable(Date())
        let searchButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        // 변환한 날짜를 내보낼 객체
        let selectDate: Observable<String> = Observable("")
        let boxOffice: Observable<[Movie]> = Observable([])
    }
    
    // VM과 VC 사이를 왔다갔다 하는 애가 아님
    private var query = ""
     
    init() {
        print("BoxOfficeViewModel Init")
        
        input = Input()
        output = Output()
         
        transform()
    }
    
    func transform() {
        input.selectedDate.bind { date in
            print("inputSelectedDate bind")
            self.convertDate(date: date)
        }
        
        input.searchButtonTapped.bind { _ in
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
        output.selectDate.value = string
        
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
                self.output.boxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
                print("=====")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
