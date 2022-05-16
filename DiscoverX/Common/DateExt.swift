//
//  DateExt.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation

extension Date {
    
   func changeTo(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
