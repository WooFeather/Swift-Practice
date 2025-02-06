//
//  MarketViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

final class MarketViewModel {
    
    // 사실 아무런 데이터를 전달하지 않아서 이렇게 Void의 튜플타입을 써도 되지만, Bool타입이나 Int타입을 써도 괜찮음
    // 근데 그러한 데이터들 중에서 Void타입의 튜플형태가 가장 작아서 쓰는거임
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    let outputMarket: Observable<[Market]> = Observable([])
    let outputTitle: Observable<String?> = Observable(nil)
    
    init() {
        print("MarketViewModel Init")
        
        inputViewDidLoadTrigger.lazyBind { _ in
            print("inputViewDidLoadTrigger bind")
            self.fetchUpbitMarketAPI()
        }
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    func fetchUpbitMarketAPI() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                
                self.outputMarket.value = success
                self.outputTitle.value = success.randomElement()?.korean_name
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
