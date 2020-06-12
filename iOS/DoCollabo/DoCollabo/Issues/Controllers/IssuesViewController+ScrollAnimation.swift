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
            } else if currentHeaderViewHeight <= TitleHeaderView.huggedHeight {
                guard currentHeaderViewHeight >= TitleHeaderView.huggedHeight else { return }
                titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderBackgroundView.huggedHeight
            }
        } else if offsetY < 0 {
            if currentHeaderViewHeight < TitleHeaderView.stretchedHeight {
                let backgroundOffsetY = offsetY * (backgroundViewDiff / headerViewDiff)
                titleHeaderBackgroundViewHeightAnchor.constant -= backgroundOffsetY
            } else if currentHeaderViewHeight >= TitleHeaderView.stretchedHeight {
                guard currentHeaderViewHeight <= TitleHeaderView.stretchedHeight else { return }
                titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderBackgroundView.stretchedHeight
            }
        }
        
        if offsetY > 0 {
            if currentHeaderViewHeight > TitleHeaderView.huggedHeight {
                titleHeaderViewHeightAnchor.constant -= offsetY
                let heightOffset = TitleHeaderView.stretchedHeight - currentHeaderViewHeight
                let alpha = (heightOffset / headerViewDiff)
                titleHeaderView.titleLabel.alpha = 1.0 - alpha
                titleHeaderView.smallTitleLabel.alpha = alpha
            } else if currentHeaderViewHeight <= TitleHeaderView.huggedHeight {
                titleHeaderView.hugged()
                titleHeaderViewHeightAnchor.constant = TitleHeaderView.huggedHeight
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
            }
        } else if offsetY < 0 {
            if currentHeaderViewHeight < TitleHeaderView.stretchedHeight {
                titleHeaderViewHeightAnchor.constant -= offsetY
                let heightOffset = currentHeaderViewHeight - TitleHeaderView.huggedHeight
                let alpha = (heightOffset / headerViewDiff)
                titleHeaderView.titleLabel.alpha = alpha
                titleHeaderView.smallTitleLabel.alpha = 1.0 - alpha
            } else if currentHeaderViewHeight >= TitleHeaderView.stretchedHeight {
                titleHeaderView.stretched()
                titleHeaderViewHeightAnchor.constant = TitleHeaderView.stretchedHeight
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
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
            UIView.animate(withDuration: 0.5) {
                self.titleHeaderView.hugged()
                self.view.layoutIfNeeded()
            }
        } else {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.stretchedHeight
            titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderBackgroundView.stretchedHeight
            UIView.animate(withDuration: 0.5) {
                self.titleHeaderView.stretched()
                self.view.layoutIfNeeded()
            }
        }
    }
}
