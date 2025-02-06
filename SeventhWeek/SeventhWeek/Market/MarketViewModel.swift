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
    let inputCellSelected: Observable<Market?> = Observable(nil)
//    let inputCellTitle: Observable<String?> = Observable(nil)
//    let inputDetailMarket: Observable<Market?> = Observable(nil)
    
    let outputMarket: Observable<[Market]> = Observable([])
    let outputTitle: Observable<String?> = Observable(nil)
    let outputCellSelected: Observable<Market?> = Observable(nil)
//    let outputDetailTitle: Observable<String?> = Observable(nil)
//    let outputDetailMarket: Observable<Market?> = Observable(nil)
    
    init() {
        print("MarketViewModel Init")
        
        inputViewDidLoadTrigger.lazyBind { _ in
            print("inputViewDidLoadTrigger bind")
            self.fetchUpbitMarketAPI()
        }
        
        inputCellSelected.lazyBind { _ in
            print("inputCellSelected bind")
            // 아무 로직 없이, 그냥 신호만 전달
            
            // 값전달 로직
//            self.outputDetailTitle.value = self.inputCellTitle.value
//            self.outputDetailMarket.value = self.inputDetailMarket.value
            self.outputCellSelected.value = self.inputCellSelected.value
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
