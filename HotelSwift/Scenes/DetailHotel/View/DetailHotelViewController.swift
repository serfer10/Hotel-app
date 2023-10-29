

import UIKit
import SnapKit

class DetailHotelViewController: UIViewController {
    enum DetailSection {
        case photos, main, description
    }
    
    var presenter: DetailViewPresenterProtocol!
    
    private var detailTableView: UITableView = UITableView()
    
    let sections: [DetailSection] = [.photos, .main, .description]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(ScrollTablePhotoHotelCell.self, forCellReuseIdentifier: "CellPhoto")
        detailTableView.register(MainInfoHotelCell.self, forCellReuseIdentifier: "CellMain")
        detailTableView.register(DescriptionHotelCell.self, forCellReuseIdentifier: "CellDescription")
        
        self.navigationItem.title = presenter.getName()
        
        self.view.addSubview(detailTableView)
        
        detailTableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

extension DetailHotelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = sections[indexPath.row]
        
        switch currentSection {
        case .photos:
            let cellPhoto = detailTableView.dequeueReusableCell(withIdentifier: "CellPhoto", for: indexPath) as! ScrollTablePhotoHotelCell
            cellPhoto.setData(images: presenter.getImages())
            return cellPhoto
        case .main:
            let cellMain = detailTableView.dequeueReusableCell(withIdentifier: "CellMain", for: indexPath) as! MainInfoHotelCell
            cellMain.detailNameLabel.text = presenter.getName()
            cellMain.addressView.detailAddress.text = presenter.getAddress()
            cellMain.phoneView.detailPhone.text = presenter.getPhoneNumber()
            cellMain.starNumber(value: presenter.getStar())
            return cellMain
        case .description:
            let cellDescription = detailTableView.dequeueReusableCell(withIdentifier: "CellDescription", for: indexPath) as! DescriptionHotelCell
            cellDescription.descriptionLabel.text = presenter.getDescription()
            return cellDescription
        }
    }
}

extension DetailHotelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.row] {
        case .photos:
            return 260
        case .main:
            return UITableView.automaticDimension
        case .description:
            return UITableView.automaticDimension
        }
    }
}

extension DetailHotelViewController: DetailViewProtocol { }
