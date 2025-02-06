//
//  MarketViewController.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import UIKit
import SnapKit

final class MarketViewController: UIViewController {
  
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "MarketCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    private let viewModel = MarketViewModel()

    deinit {
        print("MarketViewController Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        bindData()
    }
    
    // VM에서 VC로 바인딩해줄 데이터. 뷰모델에서 받아와서 뷰에 업데이트
    private func bindData() {
        // VC의 viewDidLoad시점에 VM에게 무언가를 전달
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputMarket.lazyBind { _ in
            print("outputMarket bind")
            self.tableView.reloadData()
        }
        
        viewModel.outputTitle.bind { text in
            self.navigationItem.title = text
        }
        
        viewModel.outputCellSelected.bind { data in
            print("outputCellSelected bind")
            
            guard data != nil else {
                print("nil이라 화면전환 되면 안됨")
                return
            }
            
            let vc = MarketDetailViewController()
//            vc.navigationItem.title = self.viewModel.inputCellTitle.value
            vc.viewModel.outputOneMarket.value = data?.korean_name
//            vc.viewModel.outputOneMarket.value = self.viewModel.outputDetailMarket.value
            self.navigationController?.pushViewController(vc, animated: true)
            
//            self.navigationController?.pushViewController(EmptyViewController(), animated: true)
        }
    }
}

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarket.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
        let data = viewModel.outputMarket.value[indexPath.row]
        cell.textLabel?.text = "\(data.korean_name) | \(data.english_name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
        let data = viewModel.outputMarket.value[indexPath.row]
        
//        viewModel.inputDetailMarket.value = data
        viewModel.inputCellSelected.value = data
//        viewModel.inputCellTitle.value = data.korean_name
    }
}

extension MarketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

extension MarketViewController {
    
    private func configureView() {
        navigationItem.title = "마켓 목록"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
