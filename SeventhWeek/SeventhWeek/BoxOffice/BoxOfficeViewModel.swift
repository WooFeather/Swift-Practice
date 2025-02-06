//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation

class BoxOfficeViewModel {
    
    let outputBoxOffice = [Movie(rank: "10", movieNm: "테스트", audiCnt: "123")]
     
    init() {
        print("BoxOfficeViewModel Init")
         
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
}
