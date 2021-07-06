//
//  UIView.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

extension UIView {
    
    /// Function to add an array of subviews for autolayout
    /// - Parameter subViews: array of subviews
    func addSubViewsForAutoLayout(_ subViews: [UIView]) {
        
        for subview in subViews {
            
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
}
