//
//  TableViewExtension.swift
//  ChatBubbleUI
//
//  Created by Kumar Lav on 25/08/21.
//

import UIKit

public extension UITableView {
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let bundle = Bundle(for: cellClass)
        let nib = UINib(nibName: identifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let bundle = Bundle(for: viewClass)
        let nib = UINib(nibName: identifier, bundle: bundle)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1), at: .bottom, animated: animated)
        }
    }

    func setNoDataFoundMessage(message: String) {
        let noDataFoundView = NoDataFoundView()
        noDataFoundView.messageLabel.text = message
        self.backgroundView = noDataFoundView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }

}

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
