
import UIKit
import SnapKit

class HotelsListViewController: UIViewController {
    var presenter: HotelsListViewPresenterProtocol! 
    
    private var listTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.rowHeight = 110
        listTableView.register(HotelsCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(listTableView)
        self.navigationItem.title = presenter.title
        
        listTableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

extension HotelsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HotelsCell
        cell.nameLabel.text = presenter.getHotelName(index: indexPath.row)
        cell.addressLabel.text = presenter.getHotelAddress(index: indexPath.row)
        cell.starNumber(value: presenter.getHotelStar(index: indexPath.row))
        cell.hotelImageView.loadImage(url: presenter.getHotelFirsImage(index: indexPath.row))
        
        return cell
    }
}

extension HotelsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel = presenter.hotels[indexPath.row]
        presenter.tapOnTheHotel(hotels: hotel)
    }
}

extension HotelsListViewController: HotelsListViewProtocol {
    func succes() {
        listTableView.reloadData()
    }
    
    func failure(error: Error) {
        
        //можно показать алерт
        print(error.localizedDescription)
        
    }
}



