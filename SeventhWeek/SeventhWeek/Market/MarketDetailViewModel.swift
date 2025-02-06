//
//  MarketDetailViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/6/25.
//

import Foundation

final class MarketDetailViewModel {
    var outputOneMarket: Observable<Market?> = Observable(nil)
    
    init() {
        print("MarketDetailViewModel init")
    }
    
    deinit {
        print("MarketDetailViewModel Deinit")
    }
}
