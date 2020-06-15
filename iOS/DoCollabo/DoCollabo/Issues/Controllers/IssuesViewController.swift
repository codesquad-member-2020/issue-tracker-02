//
//  IssuesViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Alamofire

final class IssuesViewController: UIViewController {

    @IBOutlet weak var titleHeaderBackgroundView: TitleHeaderBackgroundView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView! {
        didSet {
            titleHeaderView.configureTitle("이슈")
        }
    }
    @IBOutlet weak var issuesCollectionView: IssuesCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleHeaderBackgroundViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderBackgroundViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var titleHeaderViewHeightAnchor: NSLayoutConstraint!
    
    private var issuesUseCase: UseCase!
    private var dataSource: IssuesCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fakeConfigureToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    private func configure() {
        configureCollectionViewDelegate()
        configureCollectionViewDataSource()
        configureUseCase()
        hideViews()
    }
    
    private func fakeConfigureToken() {
        UserDefaults.standard.removeObject(forKey: .jwtToken)
    }
    
    private func checkToken() {
        guard let token = UserDefaults.standard.object(forKey: .jwtToken) as? String
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
        singInViewController.modalPresentationStyle = .fullScreen
        present(singInViewController, animated: true, completion: nil)
    }
    
    private func fetchIssues() {
        let request = FetchIssuesRequest().asURLRequest()
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
        let alertController = ErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configure(actionTitle: "재요청") { (_) in
            self.fetchIssues()
        }
        alertController.configure(actionTitle: "확인") { (_) in
            return
        }
        self.present(alertController, animated: true)
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

// MARK:- Loading UI

extension IssuesViewController {
    private func hideViews() {
        titleHeaderBackgroundView.alpha = 0
        titleHeaderView.alpha = 0
        issuesCollectionView.alpha = 0
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    private func showViews() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.titleHeaderBackgroundView.alpha = 1
                self.activityIndicator.alpha = 0
        }, completion: { _ in
            self.activityIndicator.stopAnimating()
        })
        UIView.animate(
            withDuration: 1,
            delay: 0.2,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.titleHeaderView.alpha = 1
        })
        UIView.animate(
            withDuration: 1,
            delay: 0.4,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.issuesCollectionView.alpha = 1
        })
    }
}

// MARK:- Configuration

extension IssuesViewController {
    private func configureCollectionViewDelegate() {
        issuesCollectionView.delegate = self
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = IssuesCollectionViewDataSource(changedHandler: { (_) in
            self.issuesCollectionView.reloadData()
            self.showViews()
        })
        issuesCollectionView.dataSource = dataSource
    }
    
    private func configureUseCase() {
        issuesUseCase = UseCase(networkDispatcher: AF)
    }
}
