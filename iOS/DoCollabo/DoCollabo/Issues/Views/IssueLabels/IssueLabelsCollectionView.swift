//
//  IssueLabelsCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueLabelsCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: LeftAlignedCollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .tertiarySystemBackground
        isScrollEnabled = false
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: IssueLabelCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: IssueLabelCell.self))
    }
}
