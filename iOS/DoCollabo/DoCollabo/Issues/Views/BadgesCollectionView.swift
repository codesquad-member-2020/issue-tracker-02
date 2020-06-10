//
//  BadgesCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class BadgesCollectionView: UICollectionView {

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
        isScrollEnabled = false
        dataSource = self
        delegate = self
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: BadgeCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: BadgeCell.self))
    }
}

extension BadgesCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BadgeCell.self),
            for: indexPath) as! BadgeCell
        return cell
    }
}

extension BadgesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 20)
    }
}
