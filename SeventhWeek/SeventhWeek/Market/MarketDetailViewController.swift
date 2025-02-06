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

        configureView()
        bindData()
    }

    private func configureView() {
        view.backgroundColor = .lightGray
    }
    
    private func bindData() {
        viewModel.outputOneMarket.bind { market in
            print("outputOneMarket bind")
            self.navigationItem.title = market?.korean_name ?? "마켓 없음"
        }
    }
}
