//
//  Launches.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

// MARK: - Launches
struct Launch: Decodable {
    let rocket: String
    let name: String
    let launchDate: Date
    let missionImageUrl: String?
    let success: Bool?
    let webcastLink: String?
    let articleLink: String?
    let wikipediaLink: String?
    
    var launchDateString: String {
        launchDate.changeTo(format: "dd-MM-YYYY 'at' HH:mm")
    }
    
    var daysFrom: Int {
        Calendar.current.numberOfDaysBetween(from: Date.now, to: launchDate)
    }
    
    var launchYear: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: launchDate)
        return components.year ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case launchDate = "date_unix"
        case missionImage = "small"
        case success = "success"
        case articleLink = "article"
        case webcastLink = "webcast"
        case wikipediaLink = "wikipedia"
        case rocket, name, links, patch
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocket = try container.decode(String.self, forKey: .rocket)
        name = try container.decode(String.self, forKey: .name)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        let unixTimeStamp = try container.decode(Double.self, forKey: .launchDate)
        launchDate = Date(timeIntervalSince1970: unixTimeStamp)
        let links = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .links)
        let patch = try links.nestedContainer(keyedBy: CodingKeys.self, forKey: .patch)
        missionImageUrl = try patch.decodeIfPresent(String.self, forKey: .missionImage)
        articleLink = try links.decodeIfPresent(String.self, forKey: .articleLink)
        webcastLink = try links.decodeIfPresent(String.self, forKey: .webcastLink)
        wikipediaLink = try links.decodeIfPresent(String.self, forKey: .wikipediaLink)
    }
}

typealias Launches = [Launch]
