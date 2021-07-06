//
//  WeatherListVIew.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

class WeatherListVIew: UIView {
    
    let tableView: UITableView
    let noResultLabel: UILabel
    
    /// constant values used
    private struct ViewTraits {
        
        static let estimatedRowHeight: CGFloat = 120.0
    }
    
    var isNoResultToBeShown: Bool = false {
        
        didSet {
            
            noResultLabel.isHidden = !isNoResultToBeShown
        }
    }
    
    override init(frame: CGRect) {
        
        tableView = UITableView()
        tableView.register(WeatherListTableViewCell.self, forCellReuseIdentifier: WeatherListTableViewCell.cellIdentifier)
        tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        noResultLabel = UILabel()
        noResultLabel.textColor = .black
        noResultLabel.font = UIFont.systemFont(ofSize: 18.0)
        noResultLabel.isHidden = true
        noResultLabel.text = "No results found."
        noResultLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubViewsForAutoLayout([tableView, noResultLabel])
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noResultLabel.heightAnchor.constraint(equalToConstant: 20.0),
            noResultLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 10.0),
            noResultLabel.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -10.0),
            noResultLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            noResultLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
}
