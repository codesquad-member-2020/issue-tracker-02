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
    private var moreViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentMoreView()
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
        let button = MoreOptionButton()
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: event)
        return button
    }
    
    func addOptions(buttons: UIButton...) {
        moreView.addOptions(buttons: buttons)
    }
}

extension MoreViewController {
    private func presentMoreView() {
        moreViewBottomConstraint.constant = 0
        UIView.animateCurveEaseOut(withDuration: 0.4, animations: {
            self.backgroundView.alpha = 0.5
            self.view.layoutIfNeeded()
        })
    }
    
    private func dismissMoreView() {
        moreViewBottomConstraint.constant = 500
        UIView.animateCurveEaseOut(
            withDuration: 0.3,
            animations: {
                self.backgroundView.alpha = 0
                self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK:- MoreViewDelegate

extension MoreViewController: MoreViewDelegate {
    func dismissButtonDidTap() {
        dismissMoreView()
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
        dismissMoreView()
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
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 0))
        moreViewBottomConstraint = NSLayoutConstraint(
            item: moreView!,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 500)
        moreViewBottomConstraint.isActive = true
    }
}
