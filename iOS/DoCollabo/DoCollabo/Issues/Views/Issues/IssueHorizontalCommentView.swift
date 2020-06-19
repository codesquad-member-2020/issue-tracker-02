//
//  IssueHorizontalCommentView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/17.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalCommentView: UIView {
    
    private var imageView: UIImageView!
    private var label: UILabel!
    
    private let commentImage: UIImage? = UIImage(named: "comment.right")
    private let imageViewHeight: CGFloat = 30.0
    private let fontSize: CGFloat = 13.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureCommentView(with issue: Issue) {
        label.text = "2"
        #warning("should change comment view label text")
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        imageView = UIImageView(image: commentImage)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configureLayout() {
        addSubview(imageView)
        imageView.addSubview(label)
        imageView.fillSuperview()
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        label.centerInSuperview(constantX: 0, constantY: -2)
    }
}
