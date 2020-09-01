//
//  TitleHeaderView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol HeaderViewActionDelegate {
    func newButtonDidTap()
}

@IBDesignable
final class TitleHeaderView: UIView {

    static let stretchedHeight: CGFloat = 144.0
    static let huggedHeight: CGFloat = 68.0
    private let searchBarViewHeight: CGFloat = 32.0

    var delegate: HeaderViewActionDelegate?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smallTitleLabel: UILabel!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBarViewHeightAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func hasSearchBar() {
        searchBarView.isHidden = false
    }
    
    func changeUI(titleSize: CGFloat, backgroundColor: UIColor) {
        titleLabel.font = UIFont.systemFont(ofSize: titleSize, weight: .heavy)
        backgroundView.backgroundColor = backgroundColor
        titleLabel.textColor = .label
    }
    
    func updateSearchBar(offsetProgress: CGFloat) {
        searchBarView.alpha = offsetProgress
        searchBarView.isHidden = false
        searchBarViewHeightAnchor.constant = searchBarViewHeight * offsetProgress
    }

    func stretched() {
        titleLabel.alpha = 1
        smallTitleLabel.alpha = 0
        searchBarView.alpha = 1
        searchBarViewHeightAnchor.constant = searchBarViewHeight
    }

    func hugged() {
        titleLabel.alpha = 0
        smallTitleLabel.alpha = 1
        searchBarView.alpha = 0
        searchBarView.isHidden = true
    }

    func configureTitle(_ text: String) {
        titleLabel.text = text
        smallTitleLabel.text = text
    }

    func hideSearchTextField() {
        searchTextField.isHidden = true
    }
    
    func didBeginEditing() {
        searchTextField.text = ""
    }
    
    func searchText() -> String? {
        return searchTextField.text
    }
    
    func configureDelegate(handler: (UITextField) -> Void) {
        handler(searchTextField)
    }
    
    @IBAction func pressAddButton(_ sender: UIButton) {
        delegate?.newButtonDidTap()
    }
}

// MARK:- Configuration

extension TitleHeaderView {
    private func configure() {
        configureNib()
        configureUI()
    }

    private func configureUI() {
        backgroundView.roundCorner(cornerRadius: 16.0)
        smallTitleLabel.alpha = 0
        searchBarView.roundCorner(cornerRadius: 12.0)
    }

    private func configureNib() {
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
