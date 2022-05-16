//
//  CompanyInfo.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

// MARK: - CompanyInfo
struct CompanyInfo: Codable {
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Int
    
    enum CodingKeys: String, CodingKey {
        case launchSites = "launch_sites"
        case founder, name, founded, employees, valuation
    }
    
    var valuationString: String {
        let number = Double(valuation)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return "\(billion)B"
        } else if million >= 1.0 {
            return "\(million)M"
        } else if thousand >= 1.0 {
            return ("\(thousand)K")
        } else {
            return "\(Int(number))"
        }
    }
}
 

