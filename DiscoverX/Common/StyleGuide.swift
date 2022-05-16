//
//  StyleGuide.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation
import UIKit

enum StyleGuide {
    case title
    case value
    case heading
    
    var font: UIFont {
        switch self {
        case .title:
            return UIFont(name: "HelveticaNeue-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
        case .value:
            return UIFont(name: "HelveticaNeue-Light", size: 14) ?? UIFont.systemFont(ofSize: 14)
        case .heading:
            return UIFont(name: "HelveticaNeue", size: 16) ?? UIFont.systemFont(ofSize: 16)
        }
        
    }
}
