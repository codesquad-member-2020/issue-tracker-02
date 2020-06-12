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
        let currentHeight = titleHeaderViewHeightAnchor.constant
        let diff = TitleHeaderView.stretchedHeight - TitleHeaderView.huggedHeight
        
        if offsetY > 0 {
            if currentHeight > TitleHeaderView.huggedHeight {
                titleHeaderViewHeightAnchor.constant -= offsetY
                let heightOffset = TitleHeaderView.stretchedHeight - currentHeight
                let alpha = (heightOffset / diff)
                titleHeaderView.titleLabel.alpha = 1.0 - alpha
                titleHeaderView.smallTitleLabel.alpha = alpha
            } else if currentHeight <= TitleHeaderView.huggedHeight {
                titleHeaderView.hugged()
                guard currentHeight != TitleHeaderView.huggedHeight else { return }
                titleHeaderViewHeightAnchor.constant = TitleHeaderView.huggedHeight
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
            }
        } else if offsetY < 0 {
            if currentHeight < TitleHeaderView.stretchedHeight {
                titleHeaderViewHeightAnchor.constant -= offsetY
                let heightOffset = currentHeight - TitleHeaderView.huggedHeight
                let alpha = (heightOffset / diff)
                titleHeaderView.titleLabel.alpha = alpha
                titleHeaderView.smallTitleLabel.alpha = 1.0 - alpha
            } else if currentHeight >= TitleHeaderView.stretchedHeight {
                guard currentHeight != TitleHeaderView.stretchedHeight else { return }
                titleHeaderViewHeightAnchor.constant = TitleHeaderView.stretchedHeight
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentHeight = titleHeaderViewHeightAnchor.constant
        
        guard currentHeight != TitleHeaderView.huggedHeight ||
            currentHeight != TitleHeaderView.stretchedHeight
        else {
            return
        }
        
        let maximumOfDiff = TitleHeaderView.stretchedHeight - TitleHeaderView.huggedHeight
        let diff = currentHeight - TitleHeaderView.huggedHeight
        let diffOffsetRatio = diff / maximumOfDiff
        if diffOffsetRatio < 0.5 {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.huggedHeight
            UIView.animate(withDuration: 0.3) {
                self.titleHeaderView.hugged()
                self.view.layoutIfNeeded()
            }
        } else {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.stretchedHeight
            UIView.animate(withDuration: 0.3) {
                self.titleHeaderView.stretched()
                self.view.layoutIfNeeded()
            }
        }
    }
}
