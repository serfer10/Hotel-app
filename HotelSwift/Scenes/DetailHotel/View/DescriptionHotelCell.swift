

import UIKit

class DescriptionHotelCell: BaseCell {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
        }
    }
}

