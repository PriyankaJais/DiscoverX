//
//  UIViewExt.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
