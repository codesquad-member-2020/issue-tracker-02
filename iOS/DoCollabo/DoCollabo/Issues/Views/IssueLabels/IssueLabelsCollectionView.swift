//
//  IssueLabelsCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueLabelsCollectionView: UICollectionView {

    private var labels: [IssueLabel] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: LeftAlignedCollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func updateLabels(_ labels: [IssueLabel]) {
        self.labels = labels
    }
    
    private func configure() {
        backgroundColor = .white
        registerCollectionViewCell()
        isScrollEnabled = false
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: IssueLabelCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: IssueLabelCell.self))
    }
}

extension IssueLabelsCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IssueLabelCell.self),
            for: indexPath) as! IssueLabelCell
        cell.configureLabel(with: labels[indexPath.item])
        return cell
    }
}

extension IssueLabelsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = labels[indexPath.item].title
        let estimatedSize = self.estimatedSize(
            text: text,
            font: .systemFont(ofSize: IssueLabelCell.titleFontSize))
        let width = estimatedSize.width + IssueLabelCell.horizontalPadding
        let height = estimatedSize.height + IssueLabelCell.verticalPadding
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    private func estimatedSize(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 200)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedSize = NSString(string: text)
            .boundingRect(
                with: size,
                options: options,
                attributes: [NSAttributedString.Key.font: font],
                context: nil)
        return estimatedSize
    }
}
