//
//  LaunchListTableHeaderView.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation
import UIKit

class LaunchListTableHeaderView: UIView {
    @IBOutlet private weak var companyTitleLabel: UILabel?
    @IBOutlet private weak var companyInfoTextView: UITextView?
    @IBOutlet private weak var launchesTitleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(companyInfo: CompanyInfo?) {
        guard let companyInfo = companyInfo else {
            return
        }

        companyTitleLabel?.attributedText = NSAttributedString(string: Translations.companyTitle, attributes: [.font: StyleGuide.title.font])
        launchesTitleLabel?.attributedText = NSAttributedString(string: Translations.launchesTitle, attributes: [.font: StyleGuide.title.font])
        let companyInfoText = Translations.companyInfoTextFormat(companyInfo.name, companyInfo.founder, "\(companyInfo.founded)", companyInfo.employees, companyInfo.launchSites, companyInfo.valuationString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        let attributes = [NSAttributedString.Key.font: StyleGuide.heading.font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        companyInfoTextView?.attributedText = NSAttributedString(string: companyInfoText, attributes: attributes)
        
    }
}
