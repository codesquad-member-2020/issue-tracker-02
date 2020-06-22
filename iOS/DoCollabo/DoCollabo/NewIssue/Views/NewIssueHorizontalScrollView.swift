//
//  NewIssueHorizontalScrollView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class NewIssueHorizontalScrollView: UIScrollView {
    
    private var contentsStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func addArrangedSubview(_ view: UIView) {
        contentsStackView.addArrangedSubview(view)
    }
    
    private func configure() {
        configureStackView()
        configureLayout()
        configureUI()
    }
    
    private func configureUI() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    private func configureStackView() {
        contentsStackView = UIStackView()
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.alignment = .center
        contentsStackView.axis = .horizontal
        contentsStackView.distribution = .fillEqually
        contentsStackView.spacing = 4
        addSubview(contentsStackView)
    }
    
    private func configureLayout() {
        contentsStackView.topAnchor.constraint(equalTo: frameLayoutGuide.topAnchor).isActive = true
        contentsStackView.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor).isActive = true
        contentsStackView.bottomAnchor.constraint(equalTo: frameLayoutGuide.bottomAnchor).isActive = true
        contentsStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor).isActive = true
    }
    
}
