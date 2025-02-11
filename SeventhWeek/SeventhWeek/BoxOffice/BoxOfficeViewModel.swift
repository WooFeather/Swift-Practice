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
            self.callBoxOffice2(date: self.query)
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
    
    private func callNasaAPI() {
        
    }
    
    private func callBoxOffice2(date: String) {
        print(#function)
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kobisAPIKey)&targetDt=\(date)"
        
        let request = URLRequest(url: URL(string: url)!)
        
        print("===1: \(Thread.isMainThread)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("===2: \(Thread.isMainThread)")
            if let _ = error {
                print("오류 발생!")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                print("여기에서 상태코드 대응")
                return
            }
            
            // do try catch - error handling
            // server > client Data타입 -> Decoding
            if let data = data,
               let movieData = try? JSONDecoder().decode(BoxOfficeResult.self, from: data) {
                dump(movieData)
                self.output.boxOffice.value = movieData.boxOfficeResult.dailyBoxOfficeList
            } else {
                print("data가 없거나 movie decoding을 실패")
            }
        }.resume()
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
