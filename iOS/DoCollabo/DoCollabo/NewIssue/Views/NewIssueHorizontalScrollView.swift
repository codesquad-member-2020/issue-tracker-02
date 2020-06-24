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
    
    func removeAllSubviews() {
        contentsStackView.subviews.forEach {
            contentsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func configure() {
        configureStackView()
        configureLayout()
        configureUI()
        bounces = false
    }
    
    private func configureUI() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        clipsToBounds = true
    }
    
    private func configureStackView() {
        contentsStackView = UIStackView()
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.alignment = .center
        contentsStackView.axis = .horizontal
        contentsStackView.distribution = .fill
        contentsStackView.spacing = 4
        addSubview(contentsStackView)
    }
    
    private func configureLayout() {
        contentsStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor).isActive = true
        contentsStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor).isActive = true
        contentsStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor).isActive = true
        contentsStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor).isActive = true
        contentsStackView.heightAnchor.constraint(equalTo: frameLayoutGuide.heightAnchor).isActive = true
    }
    
}
