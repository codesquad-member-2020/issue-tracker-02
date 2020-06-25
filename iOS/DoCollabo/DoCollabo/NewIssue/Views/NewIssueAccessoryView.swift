//
//  NewIssueAccessoryView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol NewIssueAccessoryDelegate: class {
    func selectAssigneeButtonDidTap()
    func selectLabelsButtonDidTap()
    func selectMilestoneButtonDidTap()
}

final class NewIssueAccessoryView: UIView {
    
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var assigneeStackView: NewIssueHorizontalScrollView!
    @IBOutlet weak var labelStackView: NewIssueHorizontalScrollView!
    @IBOutlet weak var milestoneStackView: NewIssueHorizontalScrollView!
    
    weak var delegate: NewIssueAccessoryDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func generateAssigneeView(_ users: [User]) {
        assigneeStackView.removeAllSubviews()
        users.forEach { _ in
            let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
            add(assignee: imageView)
        }
    }
    
    func generateLabelView(_ labels: [IssueLabel]) {
        labelStackView.removeAllSubviews()
        labels.forEach {
            let label = PaddingLabel()
            let color = UIColor(hexString: $0.color)
            label.text = $0.title
            label.font = UIFont.boldSystemFont(ofSize: 12)
            color.isDark ? label.textColor = .white : nil
            label.roundCorner(cornerRadius: 12.0)
            label.backgroundColor = color
            label.clipsToBounds = true
            add(label: label)
        }
    }
    
    func generateMilestoneView(_ milestones: [Milestone]) {
        milestoneStackView.removeAllSubviews()
        milestones.forEach {
            let label = PaddingLabel()
            label.text = $0.title
            label.font = UIFont.systemFont(ofSize: 12)
            label.roundCorner(cornerRadius: 12.0)
            label.drawBorder(color: .darkText, width: 0.6)
            add(milestone: label)
        }
    }
    
    func add(assignee imageView: UIImageView) {
        assigneeStackView.addArrangedSubview(imageView)
        reloadInputViews()
    }
    
    func add(label: UILabel) {
        labelStackView.addArrangedSubview(label)
        reloadInputViews()
    }
    
    func add(milestone label: UILabel) {
        milestoneStackView.addArrangedSubview(label)
        reloadInputViews()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        configureUI()
    }
    
    private func configureUI() {
        frameView.roundCorner(cornerRadius: 12.0)
        frameView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    @IBAction func selectAssignees(_ sender: UIButton) {
        delegate?.selectAssigneeButtonDidTap()
    }
    
    @IBAction func selectLabels(_ sender: UIButton) {
        delegate?.selectLabelsButtonDidTap()
    }
    
    @IBAction func selectMilestones(_ sender: UIButton) {
        delegate?.selectMilestoneButtonDidTap()
    }
}
