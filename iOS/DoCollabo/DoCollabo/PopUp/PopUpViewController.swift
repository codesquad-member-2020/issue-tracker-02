//
//  PopUpViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    private var backgroundView: UIView!
    private var frameView: UIView!
    private var contentPlaceholderView: UIView!
    private var footerPlaceholderView: UIView!
    
    func configureContentView(_ contentView: UIView) {
        contentPlaceholderView.addSubview(contentView)
        contentView.fillSuperview()
    }
    
    func configureFooterView(_ footerView: UIView) {
        footerPlaceholderView.addSubview(footerView)
        footerView.fillSuperview()
    }
}

// MARK:- Configuration

extension PopUpViewController {
    func configure() {
        self.view.backgroundColor = .clear
        configureUI()
        configureSubViews()
        configureLayout()
        configureTapGestureRecognizer()
    }
    
    private func configureUI() {
        contentPlaceholderView = UIView()
        footerPlaceholderView = UIView()
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        frameView = UIView()
        frameView.backgroundColor = .white
        frameView.roundCorner(cornerRadius: 16.0)
    }
    
    private func configureSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(frameView)
        frameView.addSubview(contentPlaceholderView)
        frameView.addSubview(footerPlaceholderView)
    }
    
    private func configureLayout() {
        backgroundView.fillSuperview()
        frameView.centerInSuperview()
        let sidePadding: CGFloat = 24.0
        frameView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        frameView.heightAnchor.constraint(equalTo: frameView.widthAnchor, multiplier: 1.1).isActive = true
        contentPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        footerPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        
        contentPlaceholderView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 24).isActive = true
        contentPlaceholderView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: sidePadding).isActive = true
        contentPlaceholderView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -sidePadding).isActive = true
        contentPlaceholderView.bottomAnchor.constraint(equalTo: footerPlaceholderView.topAnchor, constant: -24).isActive = true
        
        footerPlaceholderView.heightAnchor.constraint(equalTo: frameView.heightAnchor, multiplier: 0.2).isActive = true
        footerPlaceholderView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -24).isActive = true
        footerPlaceholderView.leadingAnchor.constraint(equalTo: contentPlaceholderView.leadingAnchor).isActive = true
        footerPlaceholderView.trailingAnchor.constraint(equalTo: contentPlaceholderView.trailingAnchor).isActive = true
    }
    
    private func configureTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
