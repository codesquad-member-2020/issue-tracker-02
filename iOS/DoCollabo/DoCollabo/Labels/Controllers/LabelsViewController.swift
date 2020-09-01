//
//  LabelsViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelsViewController: UIViewController {

    @IBOutlet weak var titleHeaderBackgroundView: UIView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var labelsCollectionView: LabelsCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var popUpViewController: LabelPopUpViewController!
    private var moreViewController: LabelCellMoreViewController!
    
    @IBOutlet weak var titleHeaderBackgroundViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderBackgroundViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderViewHeightAnchor: NSLayoutConstraint!

    private var labelsUseCase: LabelsUseCase!
    private var dataSource: LabelsCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLabels()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: .labelCellMoreButtonDidTap,
            object: nil)
    }

    private func fetchLabels() {
        startActivityIndicator()
        let request = LabelsRequest().asURLRequest()
        labelsUseCase.getResources(request: request, dataType: [IssueLabel].self) { result in
            switch result {
            case .success(let labels):
                self.dataSource.updateLabels(labels)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
}

// MARK:- LabelCellMoreViewControllerDelegate

extension LabelsViewController: LabelCellMoreViewControllerDelegate {
    func editButtonDidTap(at indexPath: IndexPath) {
        dataSource.referLabel(at: indexPath) { (issue) in
            popUpViewController.updatePopupViewForEditing(with: issue)
            popUpViewController.configureIndexPath(indexPath)
            popUpViewController.configureEditMode(true)
            self.present(popUpViewController, animated: true, completion: nil)
        }
    }
    
    func removeLabelCell(at indexPath: IndexPath) {
        let cell = self.labelsCollectionView.cellForItem(at: indexPath) as! LabelCell
        DispatchQueue.main.async {
            UIView.animateCurveEaseOut(withDuration: 0.3, animations: {
                cell.alpha = 0
            }, completion: { _ in
                self.labelsCollectionView.performBatchUpdates({
                    self.labelsCollectionView.deleteItems(at: [indexPath])
                    self.dataSource.removeLabel(at: indexPath)
                }, completion: nil)
            })
        }
    }
}

// MARK:- Notification Action

extension LabelsViewController {
    @objc private func moreButtonDidTap(notification: Notification) {
        guard let cell = notification.object as? LabelCell else { return }
        guard let indexPath = labelsCollectionView.indexPath(for: cell) else { return }
        dataSource.referLabel(at: indexPath) { (label) in
            moreViewController.configureLabelCellMoreViewController(
                with: label,
                labelsUseCase: labelsUseCase,
                at: indexPath)
            present(moreViewController, animated: false, completion: nil)
        }
    }
}

// MARK:- Activity Indicator

extension LabelsViewController {
    private func startActivityIndicator() {
        activityIndicator.alpha = 1
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func stopActivityIndicator() {
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.activityIndicator.alpha = 0
        }) { (_) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

// MARK:- Error Alert

extension LabelsViewController {
    private func presentErrorAlert(error: Error) {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configureAction(title: "재요청") { (_) in
            self.fetchLabels()
        }
        alertController.configureDoneAction() { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}

// MARK:- HeaderViewActionDelegate

extension LabelsViewController: HeaderViewActionDelegate {
    func newButtonDidTap() {
        popUpViewController.configureRandomColor()
        popUpViewController.resetContentView()
        popUpViewController.configureEditMode(false)
        present(popUpViewController, animated: true, completion: nil)
    }
}

// MARK:- ButtonStackActionDelegate

extension LabelsViewController: LabelPopUpViewControllerDelegate {
    func submitButtonDidTap(label: IssueLabel, isEditMode: Bool, at indexPath: IndexPath? = nil) {
        if isEditMode {
            requestEditLabel(with: label, at: indexPath)
        } else {
            requestAddLabel(with: label)
        }
    }
    
    private func requestAddLabel(with label: IssueLabel) {
        encodeLabel(label) { encodedData in
            let request = LabelsRequest(method: .POST, id: nil, bodyParams: encodedData).asURLRequest()
            labelsUseCase.getStatus(request: request) { result in
                switch result {
                case .success(_):
                    self.fetchLabels()
                case .failure(let error):
                    self.presentErrorAlert(error: error)
                }
            }
        }
    }
    
    private func requestEditLabel(with label: IssueLabel, at indexPath: IndexPath?) {
        encodeLabel(label) { encodedData in
            let request = LabelsRequest(method: .PUT, id: String(label.id!), bodyParams: encodedData).asURLRequest()
            labelsUseCase.getStatus(request: request) { result in
                switch result {
                case .success(_):
                    self.updateCollectionView(with: label, at: indexPath)
                case .failure(let error):
                    self.presentErrorAlert(error: error)
                }
            }
        }
    }
    
    private func updateCollectionView(with label: IssueLabel, at indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        dataSource.updateLabel(with: label, at: indexPath)
        labelsCollectionView.performBatchUpdates({
            labelsCollectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
    
    private func encodeLabel(_ label: IssueLabel, completion: (Data) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(label)
            completion(encodedData)
        } catch {
            self.presentErrorAlert(error: NetworkError.BadRequest)
        }
    }
}

extension LabelsViewController: PopUpViewControllerDelegate {
    func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension LabelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = labelsCollectionView.frame.width * 0.9
        var estimatedSize = CGSize(width: width, height: LabelCell.height)
        dataSource.referLabel(at: indexPath) { (label) in
            if label.description != "" {
                estimatedSize.height += 26.0
            }
        }
        return estimatedSize
    }
}

// MARK:- Configuration

extension LabelsViewController {
    private func configure() {
        configureHeaderView()
        configurePopUpView()
        configureCollectionViewDelegate()
        configureCollectionViewDataSource()
        configureUseCase()
        configureNotification()
        configureMoreViewController()
        hideCollectionView()
    }
    
    private func configureMoreViewController() {
        moreViewController = LabelCellMoreViewController()
        moreViewController.delegate = self
        moreViewController.modalPresentationStyle = .overFullScreen
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moreButtonDidTap),
            name: .labelCellMoreButtonDidTap,
            object: nil)
    }
    
    private func configureCollectionViewDelegate() {
        labelsCollectionView.delegate = self
    }

    private func hideCollectionView() {
        labelsCollectionView.alpha = 0
    }

    private func configurePopUpView() {
        popUpViewController = LabelPopUpViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.configureLabelPopupViewController()
        popUpViewController.popUpViewControllerDelegate = self
        popUpViewController.labelPopUpDelegate = self
    }

    private func configureHeaderView() {
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
        titleHeaderView.configureTitle("레이블")
        titleHeaderView.hideSearchTextField()
        titleHeaderView.delegate = self
    }

    private func configureCollectionViewDataSource() {
        dataSource = LabelsCollectionViewDataSource( changedHandler: { (_) in
            self.labelsCollectionView.reloadData()
            self.stopActivityIndicator()
            self.appearCollectionView()
        })
        labelsCollectionView.dataSource = dataSource
    }
    
    private func appearCollectionView() {
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.labelsCollectionView.alpha = 1.0
        }, completion: nil)
    }

    private func configureUseCase() {
        labelsUseCase = LabelsUseCase()
    }
}
