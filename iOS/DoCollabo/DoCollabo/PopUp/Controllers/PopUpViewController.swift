//
//  PopUpViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol PopUpViewControllerDelegate: class {
    func cancelButtonDidTap()
}

class PopUpViewController: UIViewController {
    
    private var backgroundView: UIView!
    private var frameView: UIView!
    private var contentView: PopUpContentView!
    private var footerView: PopUpFooterView!
    
    weak var popUpViewControllerDelegate: PopUpViewControllerDelegate?
    
    func configureContentView(_ otherView: UIView) {
        contentView.addSubview(otherView)
        otherView.fillSuperview()
    }
    
    func configureSecondLevelBackgroundView() {
        backgroundView.alpha = 0
    }
    
    func configureSegmentView(_ view: UIView) {
        contentView.configurePlaceholderView(view)
    }
}

// MARK:- PopUpFooterViewAction

@objc extension PopUpViewController: PopUpFooterViewActionDelegate {
    func cancelButtonDidTap() {
        popUpViewControllerDelegate?.cancelButtonDidTap()
    }
    
    func resetButtonDidTap() {
        contentView.reset()
    }
}

// MARK:- Configuration

extension PopUpViewController {
    func configure() {
        self.view.backgroundColor = .clear
        configureUI()
        configureFooterView()
        configureSubViews()
        configureLayout()
        configureTapGestureRecognizer()
    }
    
    private func configureUI() {
        contentView = PopUpContentView()
        footerView = PopUpFooterView()
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        frameView = UIView()
        frameView.backgroundColor = .white
        frameView.roundCorner(cornerRadius: 16.0)
    }
    
    private func configureFooterView() {
        footerView.delegate = self
    }
    
    private func configureSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(frameView)
        frameView.addSubview(contentView)
        frameView.addSubview(footerView)
    }
    
    private func configureLayout() {
        backgroundView.fillSuperview()
        frameView.centerInSuperview()
        let sidePadding: CGFloat = 24.0
        frameView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        frameView.heightAnchor.constraint(equalTo: frameView.widthAnchor, multiplier: 1.1).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 24).isActive = true
        contentView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: sidePadding).isActive = true
        contentView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -sidePadding).isActive = true
        contentView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -24).isActive = true
        
        footerView.heightAnchor.constraint(equalTo: frameView.heightAnchor, multiplier: 0.2).isActive = true
        footerView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -24).isActive = true
        footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func configureTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
