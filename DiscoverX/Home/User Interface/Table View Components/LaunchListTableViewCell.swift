//
//  LaunchListTableViewCell.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation
import UIKit

class LaunchListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var missionImageView: UIImageView?
    @IBOutlet private weak var successImageView: UIImageView?
    @IBOutlet private weak var missionNameTitleLabel: UILabel?
    @IBOutlet private weak var missionNameLabel: UILabel?
    @IBOutlet private weak var dateTitleLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var rocketTitleLabel: UILabel?
    @IBOutlet private weak var rocketLabel: UILabel?
    @IBOutlet private weak var daysTitleLabel: UILabel?
    @IBOutlet private weak var daysLabel: UILabel?
    
    private var imageDownloadRequest: CancellationProtocol?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        missionImageView?.image = nil
        imageDownloadRequest?.cancel()
        successImageView?.image = nil
        missionNameLabel?.attributedText = nil
        dateLabel?.attributedText = nil
        rocketLabel?.attributedText = nil
        daysTitleLabel?.attributedText = nil
        daysLabel?.attributedText = nil
    }
    
    func config(launch: Launch, imageDownloader: ImageDownloadServiceProtocol) {
        
        imageDownloadRequest = imageDownloader.get(for: launch.missionImageUrl) { [weak self] image in
            self?.missionImageView?.image = image
        }
        if let missionStatus = launch.success {
            successImageView?.image = missionStatus ? UIImage(systemName: "checkmark") : UIImage(systemName: "xmark")
        } 
        
        missionNameTitleLabel?.attributedText = NSAttributedString(string: Translations.missionTitle, attributes: [.font: StyleGuide.title.font])
        dateTitleLabel?.attributedText = NSAttributedString(string: Translations.dateTitle, attributes: [.font: StyleGuide.title.font])
        rocketTitleLabel?.attributedText = NSAttributedString(string: Translations.rocketTitle, attributes: [.font: StyleGuide.title.font])
        
        missionNameLabel?.attributedText = NSAttributedString(string: launch.name, attributes: [.font: StyleGuide.value.font])
        dateLabel?.attributedText = NSAttributedString(string: launch.launchDateString, attributes: [.font: StyleGuide.value.font])
        rocketLabel?.attributedText = NSAttributedString(string: launch.rocket, attributes: [.font: StyleGuide.value.font])
        
        let daysFromText = launch.daysFrom > 0 ? Translations.daysFromNowTitle : Translations.daysSinceNowTitle
        daysTitleLabel?.attributedText = NSAttributedString(string: daysFromText, attributes: [.font: StyleGuide.title.font])
        daysLabel?.attributedText = NSAttributedString(string: String(abs(launch.daysFrom)), attributes: [.font: StyleGuide.value.font])
    }
}


