//
//  IssuesViewController+ScrollAnimation.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension IssuesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let currentHeaderViewHeight = titleHeaderViewHeightAnchor.constant
        let headerViewDiff = TitleHeaderView.stretchedHeight - TitleHeaderView.huggedHeight
        let backgroundViewDiff = TitleHeaderBackgroundView.stretchedHeight - TitleHeaderBackgroundView.huggedHeight
        
        if offsetY > 0 {
            if currentHeaderViewHeight > TitleHeaderView.huggedHeight {
                let backgroundOffsetY = offsetY * (backgroundViewDiff / headerViewDiff)
                titleHeaderBackgroundViewHeightAnchor.constant -= backgroundOffsetY
            }
        } else if offsetY < 0 {
            if currentHeaderViewHeight < TitleHeaderView.stretchedHeight {
                let backgroundOffsetY = offsetY * (backgroundViewDiff / headerViewDiff)
                titleHeaderBackgroundViewHeightAnchor.constant -= backgroundOffsetY
            }
        }
        
        if offsetY > 0 && currentHeaderViewHeight > TitleHeaderView.huggedHeight {
            titleHeaderViewHeightAnchor.constant -= offsetY
            let heightOffset = TitleHeaderView.stretchedHeight - currentHeaderViewHeight
            let progressRatio = (heightOffset / headerViewDiff)
            if progressRatio >= 0.5 {
                UIView.animateCurveEaseOut(withDuration: 0.1, animations: {
                    self.titleHeaderView.hugged()
                })
            } else {
                titleHeaderView.titleLabel.alpha = 1.0 - progressRatio
                titleHeaderView.smallTitleLabel.alpha = progressRatio
            }
        } else if offsetY < 0 && currentHeaderViewHeight < TitleHeaderView.stretchedHeight {
            titleHeaderViewHeightAnchor.constant -= offsetY
            let heightOffset = currentHeaderViewHeight - TitleHeaderView.huggedHeight
            let progressRatio = (heightOffset / headerViewDiff)
            if progressRatio >= 0.5 {
                UIView.animateCurveEaseOut(withDuration: 0.1, animations: {
                    self.titleHeaderView.stretched()
                })
            } else {
                titleHeaderView.titleLabel.alpha = progressRatio
                titleHeaderView.smallTitleLabel.alpha = 1.0 - progressRatio
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentHeaderViewHeight = titleHeaderViewHeightAnchor.constant
        
        guard currentHeaderViewHeight != TitleHeaderView.huggedHeight ||
            currentHeaderViewHeight != TitleHeaderView.stretchedHeight
        else {
            return
        }
        
        let maximumOfDiff = TitleHeaderView.stretchedHeight - TitleHeaderView.huggedHeight
        let diff = currentHeaderViewHeight - TitleHeaderView.huggedHeight
        let diffOffsetRatio = diff / maximumOfDiff
        if diffOffsetRatio < 0.5 {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.huggedHeight
            titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderBackgroundView.huggedHeight
            UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
                self.titleHeaderView.hugged()
                self.view.layoutIfNeeded()
            })
        } else {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.stretchedHeight
            titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderBackgroundView.stretchedHeight
            UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
                self.titleHeaderView.stretched()
                self.view.layoutIfNeeded()
            })
        }
    }
}
