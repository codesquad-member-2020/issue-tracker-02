//
//  LabelsCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class LabelsCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        
    }
    
    private func registerCollectionViewCell() {
        register(
            LabelCell.self,
            forCellWithReuseIdentifier: String(describing: LabelCell.self))
    }
}
