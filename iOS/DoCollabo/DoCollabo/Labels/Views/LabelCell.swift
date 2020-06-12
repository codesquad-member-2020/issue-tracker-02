//
//  LabelCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        configureNib()
    }
    
    private func configureUI() {
        backgroundView?.roundCorner(cornerRadius: 12.0)
    }
    
    private func configureNib() {
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configureCell(_ issueLabel: IssueLabel) {
        titleLabel.text = issueLabel.title
        titleBackground.backgroundColor = UIColor(hexString: issueLabel.color)
        descriptionLabel.text = issueLabel.description
    }
}
