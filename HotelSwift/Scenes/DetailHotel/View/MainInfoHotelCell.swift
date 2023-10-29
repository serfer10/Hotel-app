
import UIKit
import Cosmos

class MainInfoHotelCell: BaseCell {
    let detailNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
    
    var addressView : ContactInfoItemView = {
        let view = ContactInfoItemView()
        view.logoAddress.image = UIImage(named: "address")
        return view
    }()
    
    var phoneView : ContactInfoItemView = {
        let view = ContactInfoItemView()
        view.logoPhone.image = UIImage (named: "phone")
        return view
    }()
    
    func starNumber(value : Int)  {
        cosmosView.rating = Double(value)
    }
    
    override func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(detailNameLabel)
        contentView.addSubview(cosmosView)
        contentView.addSubview(addressView)
        contentView.addSubview(phoneView)
        
        detailNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        cosmosView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(detailNameLabel.snp.bottom).offset(6)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        addressView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cosmosView.snp.bottom).offset(6)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        phoneView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(addressView.snp.bottom).offset(6)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
        }
    }
}
