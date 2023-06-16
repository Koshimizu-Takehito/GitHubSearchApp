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
    private var items: [GitHubSearchViewItem.TableRow] = []

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func reload(with items: [GitHubSearchViewItem.TableRow]) {
        self.items = items
        self.tableView.reloadData()
    }

    func replace(item: GitHubSearchViewItem.TableRow, at index: Int) {
        self.items[index] = item
        let indexPath = IndexPath(row: index, section: 0)
        if let cell: GitHubSearchTableViewCell = tableView.cellForRow(at: indexPath) {
            cell.configure(item: item)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: GitHubSearchTableViewCell = tableView.dequeue(for: indexPath)
        cell.configure(item: item)
        return cell
    }
}
