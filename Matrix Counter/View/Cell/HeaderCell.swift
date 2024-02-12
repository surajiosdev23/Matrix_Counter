import UIKit
import SpreadsheetView

class HeaderCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 18.0/255.0, green: 92.0/255.0, blue: 33.0/255.0, alpha: CGFloat(1))
        layer.cornerRadius = 5
        clipsToBounds = true
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

