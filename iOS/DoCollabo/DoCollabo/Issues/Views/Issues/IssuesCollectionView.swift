//
//  IssuesCollectionView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        registerCollectionViewCell()
        showsVerticalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        register(
            IssueHorizontalCell.self,
            forCellWithReuseIdentifier: String(describing: IssueHorizontalCell.self))
    }
}
