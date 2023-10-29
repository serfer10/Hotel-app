

import Foundation

protocol HotelsListViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol HotelsListViewPresenterProtocol: class {
    init(view: HotelsListViewProtocol, networkProvider: NetworkProviderProtocol, database: LocalStorageProvider, router: RouterProtocol)
    var hotels: [Hotel] { get set }
    
    func tapOnTheHotel(hotels: Hotel)
    func getHotels()
    var title: String { get }
    var numberOfItems: Int { get }
    func getHotelName(index: Int) -> String
    func getHotelAddress(index: Int) -> String
    func getHotelStar(index: Int) -> Int
    func getHotelFirsImage(index: Int) -> URL
    func getHotel(index: Int) ->[Hotel]
}

class HotelsListPresenter: HotelsListViewPresenterProtocol {
    weak var view: HotelsListViewProtocol?
    var router: RouterProtocol?
    let networkProvider: NetworkProviderProtocol!
    let database: LocalStorageProvider!
    var hotels: [Hotel] = []
    var title: String {
        "Hotels"
    }
    
    required init(view:HotelsListViewProtocol,
                  networkProvider: NetworkProviderProtocol,
                  database: LocalStorageProvider,
                  router: RouterProtocol) {
        self.view = view
        self.networkProvider = networkProvider
        self.router = router
        self.database = database
        getHotels()
    }
    
    func tapOnTheHotel(hotels: Hotel) {
        router?.showDetail(hotels: hotels)
    }
    
    func getHotels() {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            networkProvider.getHotelList  { [weak self] result in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let hotels):
                        self.hotels = hotels
                        self.view?.succes()
                        self.database.saveHotels(hotels: hotels)
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        } else {
            print("Internet Connection not Available!")
            let hotels = database.getAllHotels()
            self.hotels = hotels
            self.view?.succes()
        }
    }
    
    var numberOfItems: Int {
        hotels.count
    }
    func getHotelName(index: Int) -> String {
        let hotel = hotels[index]
        return hotel.name
    }
    func getHotelAddress(index: Int) -> String {
        let hotel = hotels[index]
        return hotel.address
    }
    func getHotelStar(index: Int) -> Int {
        let hotel = hotels[index]
        return hotel.stars
    }
    func getHotelFirsImage(index: Int) -> URL {
        let hotel = hotels[index]
        return hotel.imageUrl
    }
    func getHotel(index: Int) -> [Hotel] {
        return hotels
    }
}


