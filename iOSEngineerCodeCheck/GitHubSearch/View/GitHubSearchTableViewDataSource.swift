//
//  GitHubSearchTableViewDataSource.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchTableViewDataSource: NSObject, UITableViewDataSource {
    private unowned let tableView: UITableView
    private var items: [GitHubSearchViewRowItem] = []

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func reload(with items: [GitHubSearchViewRowItem]) {
        self.items = items
        self.tableView.reloadData()
    }

    func replace(item: GitHubSearchViewRowItem, at index: Int) {
        self.items[index] = item
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? GitHubSearchTableViewCell {
            cell.configure(item: item)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = GitHubSearchTableViewCell.identifier
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GitHubSearchTableViewCell
        cell?.configure(item: item)
        return cell!
    }
}
