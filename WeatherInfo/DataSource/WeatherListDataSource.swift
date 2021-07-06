//
//  WeatherListDataSource.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

class WeatherListDataSource: NSObject {
    
    var cellViewData: [WeatherListCellViewData]
    
    init(cellViewData: [WeatherListCellViewData]) {
        
        self.cellViewData = cellViewData
    }
}

extension WeatherListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListTableViewCell.cellIdentifier) as? WeatherListTableViewCell else {
            
            return UITableViewCell()
        }
        let cellData = cellViewData[indexPath.row]
        cell.fillData(cellData)
        cell.selectionStyle = .none
        return cell
    }
}
