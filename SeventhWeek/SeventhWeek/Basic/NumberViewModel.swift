//
//  NumberViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

/*
 viewModel을 통해 UI 로직과 비즈니스 로직을 분리
 비즈니스 로직도 input과 output 로직으로 한번 더 분리
 */

class NumberViewModel {
    
    // VC가 VM의 input, output 프로퍼티만 알고 있는 상황
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        // 뷰컨에서 사용자에 의해 받아온 값 그 자체
        // 실시간으로 받아온 데이터를 didSet으로 대응하기 위해서 Field클래스 사용
        var field: Field<String?> = Field(nil) // Field("")로하면 "값을 입력해주세요"라는 텍스트가 뜸
    }
    
    struct Output {
        // VC의 레이블에 보여줄 최종 텍스트
        var text = Field("")
        // VC의 레이블 텍스트 컬러로 사용할 것 => 파랑(true), 빨강(false)
        var textColor = Field(false)
    }
    
    
    // input이 nil이라서 init에 매개변수 없어도 ㄱㅊ
    // VC에서 NumberViewModel 클래스의 인스턴스가 생성이 될 때 초기화
    init() {
        print("NumberViewModel")
        
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.field.bind { text in // text는 VC에서 amountTextField.text의 값이 value를 통해 들어온 것
            print("inputField", text ?? "")
            self.validation()
        }
    }
    
    private func validation() {
        // 1) 옵셔널에 대한 핸들링
        guard let text = input.field.value else {
            output.text.value = ""
            output.textColor.value = false
            return
        }
        
        // 2) empty값 대응
        if text.isEmpty {
            output.text.value = "값을 입력해주세요"
            output.textColor.value = false
            return // guard문이 아니더라도 early exit 가능(다음 코드를 실행x)
        }
        
        // 3) 숫자여부 파악
        guard let num = Int(text) else {
            output.text.value = "숫자만 입력해주세요"
            output.textColor.value = false
            return
        }
        
        // 4) 0 ~ 1,000,000 사이의 범위 지정
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)! // formatting된 숫자를 문자로 변환
            output.text.value = "￦" + result
            output.textColor.value = true
        } else {
            output.text.value = "백만원 이하의 금액을 입력해주세요"
            output.textColor.value = false
        }
    }
}
