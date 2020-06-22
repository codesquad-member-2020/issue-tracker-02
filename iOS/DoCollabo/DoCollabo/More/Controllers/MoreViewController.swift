//
//  MoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    private var backgroundView: UIView!
    private var moreView: MoreView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    private func animate() {
        UIView.animateCurveEaseOut(withDuration: 0.4, animations: {
            self.backgroundView.alpha = 0.5
            self.view.layoutIfNeeded()
        })
    }
    
    func configureMoreViewController() {
        configure()
    }
    
    func configureTitle(_ title: String) {
        moreView.configureTitle(title)
    }
    
    func generateButton(
        title: String,
        target: Any?,
        action: Selector,
        for event: UIControl.Event) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(target, action: action, for: event)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .light)
        return button
    }
    
    func addOptions(buttons: UIButton...) {
        moreView.addOption(buttons: buttons)
    }
}

// MARK:- MoreViewDelegate

extension MoreViewController: MoreViewDelegate {
    func dismissButtonDidTap() {
        dismiss()
    }
}

// MARK:- Configuration

extension MoreViewController {
    private func configure() {
        configureUI()
        configureLayout()
        configureTapGestureRecognizer()
    }
    
    private func configureTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundViewDidTap))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func backgroundViewDidTap() {
        dismiss()
    }
    
    private func dismiss() {
        moreView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        UIView.animateCurveEaseOut(
            withDuration: 0.3,
            animations: {
                self.view.layoutIfNeeded()
                self.backgroundView.alpha = 0
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .clear
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        moreView = MoreView()
        moreView.delegate = self
    }
    
    private func configureLayout() {
        view.addSubview(backgroundView)
        view.addSubview(moreView)
        backgroundView.fillSuperview()
        moreView.constraints(
            topAnchor: nil,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.bottomAnchor,
            trailingAnchor: view.trailingAnchor,
            size: .init(width: 0, height: 0))
    }
}
