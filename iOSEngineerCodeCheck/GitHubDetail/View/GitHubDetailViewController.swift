//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubDetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    var presenter: (any GitHubDetailPresentation)!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension GitHubDetailViewController: GitHubDetailView {
    func configure(item: GitHubDetailViewItem) {
        imageView.image = item.avatarImage
        fullNameLabel.text = item.fullName
        languageLabel.text = item.language
        starsLabel.text = item.stars
        watchersLabel.text = item.watchers
        forksLabel.text = item.forks
        issuesLabel.text = item.issues
    }

    @IBAction private func open(sender: Any) {
        presenter.safariButtoDidPush()
    }
}
