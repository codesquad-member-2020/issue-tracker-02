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
        let headerStretchedHeight = TitleHeaderView.stretchedHeight
        let headerHuggedHeight = TitleHeaderView.huggedHeight
        let headerBGStretchedHeight = TitleHeaderBackgroundView.stretchedHeight
        
        let offsetY = scrollView.contentOffset.y
        let offsetYDiff = previousOffsetY - offsetY
        let newHeight = titleHeaderViewHeightAnchor.constant + offsetYDiff
        
        // change height of header view and header background view
        titleHeaderViewHeightAnchor.constant = newHeight
        let backgroundOffsetDiff = headerBGStretchedHeight * offsetYDiff / headerStretchedHeight
        let backgroundNewHeight = titleHeaderBackgroundViewHeightAnchor.constant + backgroundOffsetDiff
        titleHeaderBackgroundViewHeightAnchor.constant = backgroundNewHeight
        
        if titleHeaderViewHeightAnchor.constant >= headerStretchedHeight {
            titleHeaderViewHeightAnchor.constant = headerStretchedHeight
            UIView.animateCurveEaseOut(withDuration: 0.2, animations: {
                self.titleHeaderView.stretched()
            })
        }
        
        if titleHeaderViewHeightAnchor.constant <= headerHuggedHeight {
            titleHeaderViewHeightAnchor.constant = headerHuggedHeight
            UIView.animateCurveEaseOut(withDuration: 0.2, animations: {
                self.titleHeaderView.hugged()
            })
        }
        
        if titleHeaderBackgroundViewHeightAnchor.constant >= headerBGStretchedHeight {
            titleHeaderBackgroundViewHeightAnchor.constant = headerBGStretchedHeight
        }
        
        if titleHeaderBackgroundViewHeightAnchor.constant <= headerHuggedHeight {
            titleHeaderBackgroundViewHeightAnchor.constant = headerHuggedHeight
        }
        
        if titleHeaderViewHeightAnchor.constant > headerHuggedHeight &&
            titleHeaderViewHeightAnchor.constant < headerStretchedHeight {
            let offsetProgress = (newHeight - headerHuggedHeight) / (headerStretchedHeight - headerHuggedHeight)
            titleHeaderView.titleLabel.alpha = offsetProgress
            titleHeaderView.smallTitleLabel.alpha = 1.0 - offsetProgress
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        scrollDidEnd(offsetY: offsetY)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        scrollDidEnd(offsetY: offsetY)
    }
    
    func scrollDidEnd(offsetY: CGFloat) {
        let currentHeaderViewHeight = titleHeaderViewHeightAnchor.constant

        guard currentHeaderViewHeight != TitleHeaderView.huggedHeight ||
            currentHeaderViewHeight != TitleHeaderView.stretchedHeight
        else {
            return
        }
        
        let offsetYDiff = previousOffsetY - offsetY
        let newHeight = titleHeaderViewHeightAnchor.constant + offsetYDiff
        let offsetProgress = (newHeight - TitleHeaderView.huggedHeight) / (TitleHeaderView.stretchedHeight - TitleHeaderView.huggedHeight)
        
        if offsetProgress < 0.5 {
            titleHeaderViewHeightAnchor.constant = TitleHeaderView.huggedHeight
            titleHeaderBackgroundViewHeightAnchor.constant = TitleHeaderView.huggedHeight
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
