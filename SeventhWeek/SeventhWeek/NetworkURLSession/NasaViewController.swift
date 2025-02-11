//
//  NasaViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/11/25.
//

import UIKit

enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

final class NasaViewController: UIViewController {

    let requestButton = UIButton()
    let progressLabel = UILabel()
    let nasaImageView = UIImageView()
    
    // 총 데이터의 양
    var total: Double = 0
    // 현재 진행중인 데이터
    var buffer: Data? {
        didSet {
            print("Buffer", buffer)
            
            // %값 계산 => label에 보여줌
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    private func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .blue
        progressLabel.backgroundColor = .white
        progressLabel.text = ""
        nasaImageView.backgroundColor = .systemBrown
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func requestButtonClicked() {
        print(#function)
        // buffer 인스턴스를 여기서 초기화 => 버튼을 누를때마다 buffer를 비워야 하기 때문에
        buffer = Data()
        callRequest()
    }
    
    private func callRequest() {
        let request = URLRequest(url: Nasa.photo, timeoutInterval: 5)
        let configuration = URLSession(
            configuration: .default, // default 환경
            delegate: self, // delegate로 응답
            delegateQueue: .main // 어느 쓰레드에서 작업할 것인지
        )
        
        // data 요청
        configuration.dataTask(with: request).resume()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    // 서버에서 최초의 응답을 받은 경우에 호출
    // response => 상태코드
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("=====1=====", response)
        
        // 상태코드가 성공일 때, contentLength를 조회
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            // 총 데이터의 양 얻기(옵셔널 처리를 곁들인)
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else {
                return .cancel
            }
            
            total = Double(contentLength)!
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터를 받아올 때마다 반복적으로 호출
    // data => 실질적인 데이터
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("=====2=====", data)
        buffer?.append(data)
    }
    
    // 100% 응답이 완료되었을 때 호출 (클로저구문은 이거 하나만 있다고 생각해도 됨)
    // error => 모든 data가 다 와야 error가 없는 것이기 때문에 마지막에 확인
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print("=====3=====", error)
        
        if let error = error {
            progressLabel.text = "문제가 발생했다"
        } else {
            // 에러가 없는 경우 => 클로저의 completionHandler 시점과 동일
            // buffer -> Data -> Image -> ImageView
            guard let buffer = buffer else {
                print("buffer 없음")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}
