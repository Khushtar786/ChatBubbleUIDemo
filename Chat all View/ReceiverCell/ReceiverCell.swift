import UIKit

class ReceiverCell: UITableViewCell {
    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var lblMsgTime: UILabel!
    @IBOutlet var lblReceiverName: UILabel!
    @IBOutlet var msgBoxView: UIView!
    @IBOutlet weak var imgviewReciever: UIImageView!

    var setData: MockData? {
        didSet {
            lblMsg.text = setData?.message
            lblReceiverName.text = setData?.receiverName
            lblMsgTime.text = setData?.time
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        msgBoxView.layer.cornerRadius = msgBoxView.frame.height / 2
    }
}
