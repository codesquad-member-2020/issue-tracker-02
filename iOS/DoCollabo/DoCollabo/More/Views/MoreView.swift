//
//  MoreView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol MoreViewDelegate: class {
    func dismissButtonDidTap()
}

final class MoreView: UIView {

    private var dismissButton: UIButton!
    private var optionsView: UIView!
    
    private enum Metric {
        static let dismissButtonTop: CGFloat = 12.0
        static let dismissButtonRight: CGFloat = 12.0
        static let dismissButtonHeight: CGFloat = 28.0
        static let optionsViewTop: CGFloat = 16.0
        static let optionsViewLeftRight: CGFloat = 20.0
        static let optionsViewBottom: CGFloat = 32.0
    }
    
    weak var delegate: MoreViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

// MARK:- Configuration

extension MoreView {
    private func configure() {
        configureUI()
        configureLayout()
        configureActions()
    }
    
    private func configureActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func dismissButtonDidTap() {
        delegate?.dismissButtonDidTap()
    }
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        roundCorner(cornerRadius: 8.0)
        dismissButton = UIButton(type: .system)
        dismissButton.setImage(UIImage(named: "button.dismiss"), for: .normal)
        dismissButton.tintColor = .lightGray
        optionsView = UIView()
        optionsView.backgroundColor = .tertiarySystemBackground
        optionsView.roundCorner(cornerRadius: 16.0)
    }
    
    private func configureLayout() {
        addSubview(dismissButton)
        addSubview(optionsView)
        dismissButton.constraints(
            topAnchor: topAnchor,
            leadingAnchor: nil,
            bottomAnchor: nil,
            trailingAnchor: trailingAnchor,
            padding: .init(
                top: Metric.dismissButtonTop,
                left: 0,
                bottom: 0,
                right: Metric.dismissButtonRight),
            size: .init(width: Metric.dismissButtonHeight, height: Metric.dismissButtonHeight))
        optionsView.constraints(
            topAnchor: dismissButton.bottomAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingAnchor,
            padding: .init(
                top: Metric.optionsViewTop,
                left: Metric.optionsViewLeftRight,
                bottom: Metric.optionsViewBottom,
                right: Metric.optionsViewLeftRight))
    }
}
