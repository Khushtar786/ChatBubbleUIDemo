
import UIKit

class NoDataFoundView: UIView {

     @IBOutlet var contentView: UIView!
     @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // first: load the view hierarchy to get proper outlets
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: NoDataFoundView.self)
        let nib = UINib(nibName: name, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        // next: append the container to our view
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

}
