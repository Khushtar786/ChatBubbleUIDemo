//  ConversationViewController.swift
//  Created by Kumar Lav on 09/08/21.

import UIKit

class ConversationViewController: UIViewController {
    // MARK: - IBOutlets_of_controller
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtViewMsg: UITextView!
    @IBOutlet weak var heightContraintofTxtView: NSLayoutConstraint!
    @IBOutlet weak var tblViewChat: UITableView!
    @IBOutlet weak var bottomViewBottomSuperViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottomSafeAreaConstraint: NSLayoutConstraint!

    // MARK: - Properties
    private var mockData = [MockConversation]()

    // MARK: - Lifecycle_Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        /*
        print("Just for the Demo of git Push and Commit")
        */
    }

    private func setUpUI() {
        updateSendButtonState(true)
        setTextViewAttributes()
        registerXIBCells()
        setTableViewRowHeight()
        setMockData()
        setKeyboardobserver()
    }

    deinit {
        removeKeyboardobserver()
    }

    // MARk:- IBActions
    @IBAction func didTapOnBackAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapOnInfoAction(_ sender: UIBarButtonItem) {
    }

    @IBAction func sendMessageAction(_ sender: UIButton) {
        sendMessage()
    }

}

// MARK: - Custom_Function's
extension ConversationViewController {
    func registerXIBCells() {
        tblViewChat.registerCellNib(SenderCell.self)
        tblViewChat.registerCellNib(ReceiverCell.self)
        tblViewChat.registerHeaderFooterViewNib(DateHeaderView.self)
    }

    func setTableViewRowHeight() {
        tblViewChat.estimatedRowHeight = 68.0
        tblViewChat.rowHeight = UITableView.automaticDimension
    }

    func setMockData() {
        let obj1 = MockData(message: ".", time: "10:00 AM", isSeen: true, receiverName: "John Deo")
        let obj2 = MockData(message: ".", time: "10:30 AM", isSeen: true, receiverName: "John Deo")
        let obj3 = MockData(message: "Hey Johnny hope you doing good", time: "11:30 AM", isSeen: false, receiverName: "John")
        let obj4 = MockData(message: "Hey Johnny hope you doing good", time: "12:30 PM", isSeen: false, receiverName: "John Deo")
        let obj5 = MockData(message: "Hey Johnny hope you doing good i recieved your package slot will delivered on.hope you doing good i recieved your package", time: "1:00 PM", isSeen: true, receiverName: "John Deo")
        let obj6 = MockData(message: "Hey Johnny hope you doing good i recieved your package slot will delivered on.hope you doing good i recieved your package", time: "3:30 PM", isSeen: true, receiverName: "Sanjeev")
        let obj7 = MockData(message: "Hey Johnny hope you doing good", time: "4:30 PM", isSeen: false, receiverName: "John Deo")
        let obj8 = MockData(message: "Hey Johnny hope you doing good i recieved your package slot will delivered on.", time: "6:00 PM", isSeen: false, receiverName: "Chayan Surana")

        let arrr1 = [obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8]
        let arrr2 = [obj1, obj2, obj3, obj4, obj5]
        let arrr3 = [obj1, obj2, obj3, obj4, obj5]
        let arrr4 = [obj1, obj2, obj8]

        let Obj1 = MockConversation(chat: arrr1, date: "Wed, Dec 21")
        let Obj2 = MockConversation(chat: arrr2, date: "Wed, Dec 20")
        let Obj3 = MockConversation(chat: arrr3, date: "Yesterday")
        let Obj4 = MockConversation(chat: arrr4, date: "Today")

        mockData.append(Obj1)
        mockData.append(Obj2)
        mockData.append(Obj3)
        mockData.append(Obj4)

        tblViewChat.reloadData()
        scrollToBottomWithDuration(interval: .zero)
    }

    func sendMessage() {
        if txtViewMsg.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        let message = txtViewMsg.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let obj1 = MockData(message: message, time: "10:00 AM", isSeen: true, receiverName: "John Deo")
        txtViewMsg.text = nil
        heightContraintofTxtView.constant = 41
        txtViewMsg.textColor = .black
        updateSendButtonState(true)
        mockData[3].chat.append(obj1)
        tblViewChat.reloadData()
        scrollToBottomWithDuration(interval: 0.3)
    }

    /// scrollToBottomWithDuration is a method to scroll tableView to the Bottom.
    /// - Parameters:
    ///   - interval: set delay to scroll
    ///   - animated: It is optional to set Animation during scroll
    func scrollToBottomWithDuration(interval: TimeInterval, animated: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.tblViewChat.scrollToBottom(animated: animated)
        }
    }
}

// MARK: - UITableViewDelegate_UITableViewDataSource
extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mockData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData[section].chat.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < mockData[indexPath.section].chat.count else {
            print("The index is out of range.")
            return UITableViewCell()
        }

        if indexPath.row % 3 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.className(ReceiverCell.self), for: indexPath) as? ReceiverCell else {
                print("DequeueReusableCell failed while casting.", #function)
                return UITableViewCell()
            }
            cell.setData = mockData[indexPath.section].chat[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.className(SenderCell.self), for: indexPath) as? SenderCell else {
                print("DequeueReusableCell failed while casting.", #function)
                return UITableViewCell()
            }
            cell.setData = mockData[indexPath.section].chat[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String.className(DateHeaderView.self)) as? DateHeaderView else {
            return UIView()
        }
        headerView.lblDate.text = mockData[section].date
        headerView.backgroundColor = .clear
        return headerView
    }
}

// MARK: - UITextView_Delegate_methods
extension ConversationViewController: UITextViewDelegate {

    func setTextViewAttributes() {
        tblViewChat.separatorColor = .clear
        txtViewMsg.delegate = self
        heightContraintofTxtView.constant = 41
        txtViewMsg.textContainerInset = UIEdgeInsets(top: 10, left: 9, bottom: 10, right: 16)
    }

    func textViewDidChange(_ textView: UITextView) {
        /// Textview's minimum height value.
         let textViewMinHeight: CGFloat = 41
        /// Textview's maximum height value.
         let textViewMaxHeight: CGFloat = 87

        guard let textViewContentHeight = txtViewMsg?.contentSize.height else { return }

        switch textViewContentHeight {
        case ..<textViewMinHeight:
            heightContraintofTxtView?.constant = textViewMinHeight
        case textViewMaxHeight...:
            heightContraintofTxtView?.constant = textViewMaxHeight
        default:
            heightContraintofTxtView?.constant = textViewContentHeight
        }
        scrollToBottomWithDuration(interval: .zero)
        updateSendButtonState(txtViewMsg.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if !txtViewMsg.text.isEmpty && txtViewMsg.text == "Type a message" {
            txtViewMsg.text = nil
            txtViewMsg.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewMsg.text.isEmpty {
            txtViewMsg.text = "Type a message"
            txtViewMsg.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3792913732)
        }
    }

    // MARK: - Hide_and_Show_Send_Button
    func updateSendButtonState(_ isHidden: Bool) {
        btnSend.isHidden = isHidden
    }
}

// MARk: - Keyboard_Managed
extension ConversationViewController {
    func setKeyboardobserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        tblViewChat.addGestureRecognizer(dismissKeyboardGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func removeKeyboardobserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            bottomViewBottomSuperViewConstraint.priority = .defaultHigh
            bottomViewBottomSafeAreaConstraint.priority = .defaultLow
            bottomViewBottomSuperViewConstraint.constant = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.1) {
                self.scrollToBottomWithDuration(interval: .zero)
                self.view.layoutIfNeeded()
            }
        }

    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomViewBottomSuperViewConstraint.priority = .defaultLow
        bottomViewBottomSafeAreaConstraint.priority = .defaultHigh
        bottomViewBottomSafeAreaConstraint.constant = .zero
        scrollToBottomWithDuration(interval: .zero)
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}

struct MockData {
    var message: String
    var time: String
    var isSeen: Bool
    var receiverName: String
}

struct MockConversation {
    var chat: [MockData]
    var date: String
}
