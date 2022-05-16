//
//  LaunchFiltersTableViewCell.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import Foundation
import UIKit

class LaunchFiltersTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel?.attributedText = nil
        accessoryType = .none
    }
    
    func config(filterTitle: String) {
        titleLabel?.attributedText = NSAttributedString(string: filterTitle, attributes: [.font: StyleGuide.value.font])
    }
    
    func updateState() {
        if accessoryType == .checkmark {
            accessoryType = .none
        } else {
            accessoryType = .checkmark
        }
    }
}
