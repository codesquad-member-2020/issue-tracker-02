//
//  IssuesViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesViewController: UIViewController {
    
    @IBOutlet weak var titleHeaderBackgroundView: TitleHeaderBackgroundView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var issuesCollectionView: IssuesCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var moreViewController: IssueCellMoreViewController!
    private var newIssueViewController: NewIssueViewController!
    private var issuesUseCase: IssuesUseCase!
    private var dataSource: IssuesCollectionViewDataSource!
    var refreshControl = UIRefreshControl()
    
    // for scroll animation
    @IBOutlet weak var titleHeaderBackgroundViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderBackgroundViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderViewHeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteToken()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .issueCellMoreButtonDidTap, object: nil)
    }
    
    private func deleteToken() {
        UserDefaults.standard.removeObject(forKey: OAuthNetworkManager.jwtToken)
    }
    
    private func configure() {
        configureHeaderView()
        configureNewIssueViewController()
        configureDelegate()
        configureCollectionViewDataSource()
        configureUseCase()
        configureNotification()
        configureMoreViewController()
        hideViews()
        configureRefreshControl()
        configureKeyboardOption()
        configureLongPressGestureRecognizer()
    }
    
    private func configureKeyboardOption() {
        issuesCollectionView.keyboardDismissMode = .interactive
    }
    
    private func configureHeaderView() {
        titleHeaderView.configureTitle("이슈")
        titleHeaderView.delegate = self
        titleHeaderView.hasSearchBar()
    }
    
    private func checkToken() {
        guard let token = UserDefaults.standard.object(forKey: OAuthNetworkManager.jwtToken) as? String
            else {
                presentSignIn()
                return
        }
        fetchIssues()
    }
    
    private func presentSignIn() {
        guard let singInViewController = storyboard?.instantiateViewController(
            identifier: String(describing: SignInViewController.self))
            else {
                return
        }
        singInViewController.modalPresentationStyle = .currentContext
        singInViewController.modalTransitionStyle = .crossDissolve
        present(singInViewController, animated: true, completion: nil)
    }
    
    func fetchIssues() {
        let request = IssuesRequest().asURLRequest()
        issuesUseCase.getResources(request: request, dataType: [Issue].self) { (result) in
            switch result {
            case .success(let issues):
                self.dataSource.updateIssues(issues)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
}

// MARK:- Error Alert

extension IssuesViewController {
    private func presentErrorAlert(error: Error) {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configureAction(title: "재요청") { (_) in
            self.fetchIssues()
        }
        alertController.configureDoneAction() { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}

// MARK:- IssueCellMoreViewControllerDelegate

extension IssuesViewController: IssueCellMoreViewControllerDelegate {
    func issueStatusDidChange(isClosed: Bool, at indexPath: IndexPath) {
        dataSource.updateIssueStatus(isClosed: isClosed, at: indexPath)
        issuesCollectionView.performBatchUpdates({
            issuesCollectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
    
    func removeIssue(at indexPath: IndexPath) {
        let cell = self.issuesCollectionView.cellForItem(at: indexPath) as! IssueHorizontalCell
        DispatchQueue.main.async {
            UIView.animateCurveEaseOut(withDuration: 0.3, animations: {
                cell.alpha = 0
            }, completion: { _ in
                self.issuesCollectionView.performBatchUpdates({
                    self.issuesCollectionView.deleteItems(at: [indexPath])
                    self.dataSource.removeIssue(at: indexPath)
                }, completion: nil)
            })
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension IssuesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.9
        let estimatedHeight: CGFloat = 300.0
        let estimatedSizeCell = IssueHorizontalCell(
            frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        dataSource.referIssue(at: indexPath) { (issue) in
            estimatedSizeCell.configureCell(with: issue)
        }
        estimatedSizeCell.layoutIfNeeded()
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(
            CGSize(width: width, height: estimatedHeight))
        return CGSize(width: width, height: estimatedSize.height)
    }
}

// MARK:- HeaderViewActionDelegate

extension IssuesViewController: HeaderViewActionDelegate {
    func newButtonDidTap() {
        present(newIssueViewController, animated: true, completion: nil)
    }
}

extension IssuesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleHeaderView.didBeginEditing()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = titleHeaderView.searchText() else { return false }
        requestIssuesWithSearchKeywords(searchText: searchText)
        textField.resignFirstResponder()
        return true
    }
    
    func requestIssuesWithSearchKeywords(searchText: String) {
        var request = IssuesRequest()
        request.append(name: .keyword, value: searchText)
        let urlRequest = request.asURLRequest()
        issuesUseCase.getResources(request: urlRequest, dataType: [Issue].self) { result in
            switch result {
            case .success(let issues):
                self.dataSource.updateIssues(issues)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
    
}

// MARK:- Configuration

extension IssuesViewController {
    private func configureLongPressGestureRecognizer() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellDidPressLong))
        recognizer.minimumPressDuration = 0.5
        issuesCollectionView.addGestureRecognizer(recognizer)
    }
    
    @objc private func cellDidPressLong(gesture : UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            let location = gesture.location(in: self.issuesCollectionView)
            guard let indexPath = self.issuesCollectionView.indexPathForItem(at: location) else { return }
            guard !moreViewController.isBeingPresented &&
                !moreViewController.isModalInPresentation &&
                !moreViewController.isBeingDismissed
            else {
                return
            }
            presentMoreViewController(at: indexPath)
            return
        }
    }
    
    private func configureMoreViewController() {
        moreViewController = IssueCellMoreViewController()
        moreViewController.delegate = self
        moreViewController.modalPresentationStyle = .overFullScreen
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moreButtonDidTap),
            name: .issueCellMoreButtonDidTap,
            object: nil)
    }
    
    @objc private func moreButtonDidTap(notification: Notification) {
        guard let cell = notification.object as? IssueHorizontalCell else { return }
        guard let indexPath = issuesCollectionView.indexPath(for: cell) else { return }
        presentMoreViewController(at: indexPath)
    }
    
    private func presentMoreViewController(at indexPath: IndexPath) {
        dataSource.referIssue(at: indexPath) { (issue) in
            moreViewController.configureIssueCellMoreViewController(
                with: issue,
                issuesUseCase: issuesUseCase,
                at: indexPath)
            present(moreViewController, animated: false, completion: nil)
        }
    }
    
    private func configureNewIssueViewController() {
        newIssueViewController = storyboard?.instantiateViewController(
            identifier: String(describing: NewIssueViewController.self))
    }
    
    private func configureDelegate() {
        issuesCollectionView.delegate = self
        newIssueViewController.delegate = self
        titleHeaderView.configureDelegate { textField in
            textField.delegate = self
        }
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = IssuesCollectionViewDataSource(changedHandler: { (_) in
            self.issuesCollectionView.reloadData()
            self.showViews()
        })
        issuesCollectionView.dataSource = dataSource
    }
    
    private func configureUseCase() {
        issuesUseCase = IssuesUseCase()
    }
    
    private func configureRefreshControl() {
        issuesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshIssues), for: .valueChanged)
    }
    
    @objc private func refreshIssues() {
        issuesCollectionView.reloadData()
    }
}

//MARK: - NewIssueActionDelegate

extension IssuesViewController: NewIssueActionDelegate {
    func submitButtonDidTap() {
        fetchIssues()
    }
}
