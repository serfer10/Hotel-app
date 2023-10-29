

import Foundation

protocol DetailViewProtocol: class {}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, router: RouterProtocol, hotel: Hotel)
    func getImages() -> [String]
    func getName() -> String
    func getDescription() -> String
    func getAddress() -> String
    func getPhoneNumber() -> String
    func getStar() -> Int
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var hotel: Hotel
    
    required init(view: DetailViewProtocol, router: RouterProtocol, hotel: Hotel) {
        self.view = view
        self.hotel = hotel
        self.router = router
    }

    func getImages() -> [String] {
        return hotel.images
    }
    func getName() -> String {
        return hotel.name
    }
    func getDescription() -> String {
        return hotel.description
    }
    func getAddress() -> String{
        return hotel.address
    }
    func getPhoneNumber() -> String {
        return hotel.phone
    }
    func getStar() -> Int {
        return hotel.stars
    }
}

