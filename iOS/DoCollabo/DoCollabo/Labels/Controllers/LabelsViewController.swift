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
    
    private func requestAddLabel(bodyParams: Data) {
        let request = LabelsRequest(method: .POST, id: nil, bodyParams: bodyParams).asURLRequest()
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

// MARK:- LabelCellMoreViewControllerDelegate

extension LabelsViewController: LabelCellMoreViewControllerDelegate {
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
        present(popUpViewController, animated: true, completion: nil)
    }
}

// MARK:- ButtonStackActionDelegate

extension LabelsViewController: PopUpViewControllerDelegate {
    func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }

    func submitButtonDidTap(title: String, description: String?, additionalData: String?) {
        dismiss(animated: true, completion: nil)
        encodeLabel(title: title, description: description, color: additionalData!)
    }
    
    private func encodeLabel(title: String, description: String?, color: String) {
        let label = IssueLabel(id: nil, title: title, color: color, description: description)
        do {
            let encodedData = try JSONEncoder().encode(label)
            requestAddLabel(bodyParams: encodedData)
        } catch {
            self.presentErrorAlert(error: NetworkError.BadRequest)
        }
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
    }

    private func configureHeaderView() {
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
        titleHeaderView.configureTitle("레이블")
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
        fetchLabels()
    }
}
