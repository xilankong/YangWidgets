//
//  YangTableViewAdapter.swift
//  Pods-YangWidgets_Example
//
//  Created by yanghuang on 2018/1/26.
//

import Foundation

@objc
open class YangTableViewAdapter: NSObject {
    
    fileprivate var tableView: UITableView!
    fileprivate var cellForRowAtIndexPath:((_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell)!
    
    public var numberOfRowsInSection: ((Int) -> Int)?
    public var numberOfSection: (() -> Int)?
    public var cellDidSelectedAtIndexPath:((_ indexPath: IndexPath, _ tableView: UITableView) -> Void)?
    public var cellHeightForRowAtIndexPath:((_ indexPath: IndexPath, _ tableView: UITableView) -> CGFloat)?
    
    public var tableViewSessionHeaderView:( (_ section: Int, _ tableView: UITableView) -> UIView)?
    public var tableViewSessionHeaderHeight:( (_ section: Int, _ tableView: UITableView) -> CGFloat)?
    
    public var tableViewSessionFooterView:( (_ section: Int, _ tableView: UITableView) -> UIView)?
    public var tableViewSessionFooterHeight:( (_ section: Int, _ tableView: UITableView) -> CGFloat)?
    
    public var tableViewDidScroll:( (_ tableView: UITableView) -> Void)?
    public var tableViewDidEndDragging:( (_ tableView: UITableView) -> Void)?
    
    //MARK: - 初始化
    public init(_ tableView: UITableView, _ cellForRowAtIndexPath: @escaping ((_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell)) {
        self.tableView = tableView
        self.cellForRowAtIndexPath = cellForRowAtIndexPath
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

//MARK: - tableView代理
extension YangTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection?() ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAtIndexPath(indexPath, tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellDidSelectedAtIndexPath?(indexPath, tableView)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightForRowAtIndexPath?(indexPath, tableView) ?? 44.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewSessionHeaderView?(section, tableView)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSessionHeaderHeight?(section, tableView) ?? CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableViewSessionFooterView?(section, tableView)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewSessionFooterHeight?(section, tableView) ?? CGFloat.leastNormalMagnitude
    }
    
}

//MARK: - scrollView代理
extension YangTableViewAdapter: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            tableViewDidScroll?(tableView)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let tableView = scrollView as? UITableView {
            tableViewDidEndDragging?(tableView)
        }
    }
}

//MARK: - 删增
extension YangTableViewAdapter {
    
    func insertRows(indexPaths: [IndexPath]!, atTableView tableView: UITableView!, animation: UITableViewRowAnimation = .fade) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: animation)
        tableView.endUpdates()
    }
    func insertSections(sections: IndexSet, atTableView tableView: UITableView!, animation: UITableViewRowAnimation = .fade) {
        tableView.beginUpdates()
        tableView.insertSections(sections, with: animation)
        tableView.endUpdates()
    }
    func removeRows(indexPaths: [IndexPath]!, atTableView tableView: UITableView!, animation: UITableViewRowAnimation = .fade) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: animation)
        tableView.endUpdates()
    }
    func removeSection(sections: IndexSet, atTableView tableView: UITableView!, animation: UITableViewRowAnimation = .fade) {
        tableView.beginUpdates()
        tableView.deleteSections(sections, with: animation)
        tableView.endUpdates()
    }
}
