//
//  Translations.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 16/05/2022.
//

import Foundation

struct Translations {
    static var parsingErrorMessage: String { return Translations.value("ParsingErrorMessage") }
    static var emptyDataErrorMessage: String { return Translations.value("EmptyDataErrorMessage") }
    static var missionTitle: String { return Translations.value("MissionTitle") }
    static var dateTitle: String { return Translations.value("DateTitle") }
    static var rocketTitle: String { return Translations.value("RocketTitle") }
    static var daysFromNowTitle: String { return Translations.value("DaysFromNowTitle") }
    static var daysSinceNowTitle: String { return Translations.value("DaysSinceNowTitle") }
    static var homeTitle: String { return Translations.value("HomeTitle") }
    static var companyTitle: String { return Translations.value("CompanyTitle") }
    static var launchesTitle: String { return Translations.value("LaunchesTitle") }
    static func companyInfoTextFormat(_ p1: String, _ p2: String, _ p3: String, _ p4: Int, _ p5: Int, _ p6: String) -> String {
        return Translations.value("CompanyInfoTextFormat", p1, p2, p3, p4, p5, p6)
    }
    static var filtersTitle: String { return Translations.value("FiltersTitle") }
    static var showOnlySuccessfulLaunches: String { return Translations.value("ShowOnlySuccessfulLaunches") }
    static var sortByAscending: String { return Translations.value("SortByAscending") }
    static var sortByDescending: String { return Translations.value("SortByDescending") }
    static var errorMessage: String { return Translations.value("ErrorMessage") }
    static var pullToRefresh: String { return Translations.value("PullToRefresh") }
    static var contextMenuTitle: String { return Translations.value("ContextMenuTitle") }
    static var openArticleTitle: String { return Translations.value("OpenArticleTitle") }
    static var openVideoTitle: String { return Translations.value("OpenVideoTitle") }
    static var openWikipediaTitle: String { return Translations.value("OpenWikipediaTitle") }
    static var clearFiltersTitle: String { return Translations.value("ClearFiltersTitle") }
    static var applyFiltersTitle: String { return Translations.value("ApplyFiltersTitle")}
}

extension Translations {
    static func value(_ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}
