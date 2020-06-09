//
//  IssuesCollectionView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class IssuesCollectionView: UICollectionView {

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
        dataSource = self
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: IssueHorizontalCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: IssueHorizontalCell.self))
    }
}

extension IssuesCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IssueHorizontalCell.self),
            for: indexPath)
        cell.backgroundColor = .red
        cell.roundCorner(cornerRadius: 12.0)
        return cell
    }
}
