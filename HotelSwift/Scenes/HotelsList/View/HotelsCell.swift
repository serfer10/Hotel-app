

import UIKit
import Cosmos

class HotelsCell: BaseCell {
    
    let hotelImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var cosmosView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.frame = CGRect(x: 0 , y: 0, width: 130, height: 30)
        cosmos.settings.updateOnTouch = false
        cosmos.settings.filledImage = UIImage(named: "GoldStar")
        cosmos.settings.emptyImage = UIImage(named: "GoldStarEmpty")
        return cosmos
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = .lightGray
        return label
    }()
    
    func starNumber(value : Int)  {
        cosmosView.rating = Double(value)
    }
    
    override func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(hotelImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cosmosView)
        contentView.addSubview(addressLabel)
        
        hotelImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.left.equalTo(5)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.left.equalTo(hotelImageView.snp.right).offset(8)
        }
        cosmosView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.right.equalTo(-5)
            make.left.equalTo(hotelImageView.snp.right).offset(8)
        }
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cosmosView.snp.bottom).offset(6)
            make.right.equalTo(-5)
            make.left.equalTo(hotelImageView.snp.right).offset(8)
        }
    }
}

