//
//  LabelsCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelsCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
            UINib(nibName: String(describing: LabelCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: LabelCell.self))
    }
}
