//
//  WeatherListTableViewCell.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    static let cellIdentifier = "WeatherListCell"
    
    let locationlabel: UILabel
    let temperatureStackView: UIStackView
    let temperatureLabel: UILabel
    let otherWeatherInfo: UILabel
    let wrapperView: UIView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        locationlabel = UILabel()
        locationlabel.numberOfLines = 2
        locationlabel.textColor = .white
        locationlabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        
        temperatureLabel = UILabel()
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 26.0, weight: .bold)
        
        otherWeatherInfo = UILabel()
        otherWeatherInfo.textColor = .white
        otherWeatherInfo.font = UIFont.systemFont(ofSize: 16.0)
        
        temperatureStackView = UIStackView()
        temperatureStackView.axis = .vertical
        temperatureStackView.alignment = .center
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(otherWeatherInfo)
        
        wrapperView = UIView()
        wrapperView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        wrapperView.layer.cornerRadius = 10.0
        wrapperView.layer.shadowColor = UIColor.black.cgColor
        wrapperView.layer.shadowOpacity = 1
        wrapperView.layer.shadowOffset = .zero
        wrapperView.layer.shadowRadius = 10
        wrapperView.addSubViewsForAutoLayout([locationlabel, temperatureStackView])
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubViewsForAutoLayout([wrapperView])
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ data: WeatherListCellViewData) {
        
        locationlabel.text = data.locationName
        temperatureLabel.text = "\(data.temperature) ℃"
        otherWeatherInfo.text = "\(data.currentWeather) \(data.maxTemp) / \(data.minTemp) ℃"
        switch data.weatherType {
        case .cloudy:
            wrapperView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            locationlabel.textColor = .black
            temperatureLabel.textColor = .black
            otherWeatherInfo.textColor = .black
        case .rainy:
            wrapperView.backgroundColor = #colorLiteral(red: 0.04023883247, green: 0.4856116665, blue: 0.6567600135, alpha: 1)
            locationlabel.textColor = .black
            temperatureLabel.textColor = .black
            otherWeatherInfo.textColor = .black
        case .clear:
            wrapperView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            locationlabel.textColor = .black
            temperatureLabel.textColor = .black
            otherWeatherInfo.textColor = .black
        case .none:
            wrapperView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            locationlabel.textColor = .white
            temperatureLabel.textColor = .white
            otherWeatherInfo.textColor = .white
        }
    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([
            
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0),
            
            locationlabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10.0),
            locationlabel.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            locationlabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            locationlabel.trailingAnchor.constraint(equalTo: temperatureStackView.leadingAnchor, constant: -10.0),
            
            temperatureStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10.0),
            temperatureStackView.widthAnchor.constraint(equalToConstant: 150.0),
            temperatureStackView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            otherWeatherInfo.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }
    
}
