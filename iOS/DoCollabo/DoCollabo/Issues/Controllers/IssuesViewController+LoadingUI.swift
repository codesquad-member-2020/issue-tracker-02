//
//  IssuesViewController+LoadingUI.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension IssuesViewController {
    internal func hideViews() {
        titleHeaderBackgroundView.alpha = 0
        titleHeaderView.alpha = 0
        issuesCollectionView.alpha = 0
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    internal func showViews() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.titleHeaderBackgroundView.alpha = 1
                self.activityIndicator.alpha = 0
        }, completion: { _ in
            self.activityIndicator.stopAnimating()
        })
        UIView.animate(
            withDuration: 1,
            delay: 0.2,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.titleHeaderView.alpha = 1
        })
        UIView.animate(
            withDuration: 0.5,
            delay: 0.4,
            usingSpringWithDamping: 1.1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.issuesCollectionView.alpha = 1
        })
    }
}
