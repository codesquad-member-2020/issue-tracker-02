//
//  IssueStatusImageView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/20.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueStatusImageView: UIImageView {
    
    static let size: CGSize = CGSize(width: 22.0, height: 22.0)
    
    private enum Image {
        static let open = UIImage(named: "issue.open")
        static let close = UIImage(named: "issue.close")
    }
    
    private enum Color {
        static let open = UIColor(named: "issue.open")
        static let close = UIColor(named: "issue.close")
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureStatusImageView(with issue: Issue) {
        if issue.isClosed {
            image = Image.close
            tintColor = Color.close
        } else {
            image = Image.open
            tintColor = Color.open
        }
    }
    
    private func configure() {
        image = Image.open
        contentMode = .scaleAspectFill
    }
}
