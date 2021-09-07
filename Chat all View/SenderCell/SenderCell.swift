import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet var lblMsgTime: UILabel!
    @IBOutlet var lblMsg: UILabel!
    @IBOutlet var msgBoxView: UIView!
    @IBOutlet var msgSeenBlueTick: UIImageView!

    var setData: MockData? {
        didSet {
            lblMsg.text = setData?.message
            lblMsgTime.text = setData?.time
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        msgBoxView.layer.cornerRadius = msgBoxView.frame.height / 2
    }
}
