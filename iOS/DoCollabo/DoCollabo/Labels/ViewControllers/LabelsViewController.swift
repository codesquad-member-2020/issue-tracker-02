//
//  LabelsViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class LabelsViewController: UIViewController {
    
    @IBOutlet weak var titleHeaderBackgroundView: UIView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var labelsCollectionView: LabelsCollectionView!
    
    let label: IssueLabel = IssueLabel(id: 1, title: "feat", color: "11aaff", description: "label descriptionlabel descriptionlabel descriptionlabel descriptionlabel descriptionlabel descriptionlabel descriptionlabel descriptionlabel description")
    lazy var labels: [IssueLabel] = [label, label, label, label, label, label, label, label, label]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        labelsCollectionView.dataSource = self
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
        titleHeaderView.configureTitle("레이블")
        collectionViewConfigure()
    }
    
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: labelsCollectionView.frame.width * 0.9, height: self.view.frame.height / 8)
        layout.scrollDirection = .vertical
        labelsCollectionView.collectionViewLayout = layout
        labelsCollectionView.showsVerticalScrollIndicator = false
    }
}

extension LabelsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LabelCell.self), for: indexPath) as! LabelCell
        cell.configureCell(with: labels[indexPath.item])
        return cell
    }
}
