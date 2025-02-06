//
//  MarketDetailViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/6/25.
//

import UIKit

final class MarketDetailViewController: UIViewController {

    let viewModel = MarketDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MarketDetailViewController viewDidLoad")

        configureView()
        bindData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear Disappear")
    }
        
    // viewDidDisappear가 아닌 => Deinit이 기준이 돼야 함
    // self 키워드가 문제가 될 수 있구나 => [weak self]로 바꿔보자
    private func bindData() {
        viewModel.outputOneMarket.bind { [weak self] market in
            print("outputOneMarket bind")
            self?.navigationItem.title = market
        }
    }
    
    deinit {
        print("MarketDetailViewController deinit")
    }
}

extension MarketDetailViewController {
    private func configureView() {
        view.backgroundColor = .lightGray
    }
}
