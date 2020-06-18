//
//  IssueLabelsViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueLabelsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var labels: [IssueLabel] = []
    var contentHeight: CGFloat {
        return collectionView.contentSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func updateLabels(_ labels: [IssueLabel]) {
        self.labels = labels
    }
    
    private func configure() {
        configureUI()
        configureCollectionView()
        configureLayout()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension IssueLabelsViewController: UICollectionViewDelegateFlowLayout {
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

// MARK:- UICollectionViewDataSource

extension IssueLabelsViewController: UICollectionViewDataSource {
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

// MARK:- Configuration

extension IssueLabelsViewController {
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureUI() {
        collectionView = IssueLabelsCollectionView()
    }
    
    private func configureLayout() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}
