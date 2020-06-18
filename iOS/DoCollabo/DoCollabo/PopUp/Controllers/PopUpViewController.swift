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
    private var contentPlaceholderView: UIView!
    private var footerView: PopUpFooterView!
    
    weak var delegate: PopUpViewControllerDelegate?
    
    func configureContentView(_ contentView: UIView) {
        contentPlaceholderView.addSubview(contentView)
        contentView.fillSuperview()
    }
}

// MARK:- PopUpFooterViewActionDelegate

extension PopUpViewController: PopUpFooterViewActionDelegate {
    func cancelButtonDidTap() {
        delegate?.cancelButtonDidTap()
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
        contentPlaceholderView = UIView()
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
        frameView.addSubview(contentPlaceholderView)
        frameView.addSubview(footerView)
    }
    
    private func configureLayout() {
        backgroundView.fillSuperview()
        frameView.centerInSuperview()
        let sidePadding: CGFloat = 24.0
        frameView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        frameView.heightAnchor.constraint(equalTo: frameView.widthAnchor, multiplier: 1.1).isActive = true
        contentPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentPlaceholderView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 24).isActive = true
        contentPlaceholderView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: sidePadding).isActive = true
        contentPlaceholderView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -sidePadding).isActive = true
        contentPlaceholderView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -24).isActive = true
        
        footerView.heightAnchor.constraint(equalTo: frameView.heightAnchor, multiplier: 0.2).isActive = true
        footerView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -24).isActive = true
        footerView.leadingAnchor.constraint(equalTo: contentPlaceholderView.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: contentPlaceholderView.trailingAnchor).isActive = true
    }
    
    private func configureTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
