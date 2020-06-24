//
//  LabelsCollectionViewDataSource.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelsCollectionViewDataSource: NSObject, UICollectionViewDataSource, ViewModelBinding {
    
    typealias Key = [IssueLabel]
    private var changedHandler: handler
    private var labels: [IssueLabel] = [] {
        didSet {
            changedHandler(labels)
        }
    }
    
    init(labels: [IssueLabel] = [], changedHandler: @escaping handler = { _ in }) {
        self.labels = labels
        self.changedHandler = changedHandler
    }
    
    func updateLabel(with label: IssueLabel, at indexPath: IndexPath) {
        labels[indexPath.item] = label
    }
    
    func referLabel(at indexPath: IndexPath, handler: (IssueLabel) -> Void) {
        let label = labels[indexPath.item]
        handler(label)
    }
    
    func removeLabel(at indexPath: IndexPath) {
        labels.remove(at: indexPath.item)
    }
    
    func updateNotify(handler: @escaping handler) {
         self.changedHandler = handler
     }
    
    func updateLabels(_ labels: [IssueLabel]) {
        self.labels = labels
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: LabelCell.self),
            for: indexPath) as! LabelCell
        let label = labels[indexPath.item]
        cell.configureCell(with: label)
        return cell
    }
}
