//
//  BadgesCollectionView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class BadgesCollectionView: UICollectionView {

    let badges: [String] = ["feedback", "iOS", "bug", "feedback", "iOS", "bug", "feedback", "feedback", "iOS", "bug", "feedback"]
    
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
        return Int.random(in: 4...11)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BadgeCell.self),
            for: indexPath) as! BadgeCell
        let randomColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1)
        cell.configureLabel(text: badges[indexPath.item], color: randomColor)
        return cell
    }
}

extension BadgesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = badges[indexPath.item]
        let estimatedSize = self.estimatedSize(
            text: text,
            font: .systemFont(ofSize: BadgeCell.titleFontSize))
        let width = estimatedSize.width + BadgeCell.horizontalPadding
        let height = estimatedSize.height + BadgeCell.verticalPadding
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
