//
//  UIViewExt.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func loadFromNib() {
        guard let view = loadViewFromNib() else {
            assertionFailure("cannot load nib for " + String(describing: type(of: self)))
            return
        }
        self.addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
}
