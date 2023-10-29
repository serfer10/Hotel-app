

import UIKit

class ContactInfoItemView: UIView, UIGestureRecognizerDelegate {
    var logoAddress: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var detailAddress: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var logoPhone: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var detailPhone: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(logoAddress)
        self.addSubview(detailAddress)
        self.addSubview(logoPhone)
        self.addSubview(detailPhone)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        detailPhone.isUserInteractionEnabled = true
        detailPhone.addGestureRecognizer(tap)
        
        logoAddress.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(24)
            make.bottom.equalTo(0)
        }
        
        detailAddress.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(logoAddress.snp.right).offset(5)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        logoPhone.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(24)
            make.bottom.equalTo(0)
        }
        
        detailPhone.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(logoPhone.snp.right).offset(5)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAction() {
        let phoneNumber = self.detailPhone.text?.removeWhitespace()
        
        if let phoneNumber = phoneNumber, let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
