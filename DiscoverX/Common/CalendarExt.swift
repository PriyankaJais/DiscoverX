//
//  CalendarExt.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation

extension Calendar {
    
    func numberOfDaysBetween(from: Date, to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return (numberOfDays.day ?? 0) + 1
    }
}
