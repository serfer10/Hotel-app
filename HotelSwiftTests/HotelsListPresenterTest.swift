

import XCTest
@testable import HotelSwift

class MockView: HotelsListViewProtocol {
    func succes() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkService: NetworkProviderProtocol {
    var hotels: [Hotel]!
    
    init() {}
    
    convenience init(hotels: [Hotel]?) {
        self.init()
        self.hotels = hotels
    }
    
    func getHotelList(completion: @escaping (Result<[Hotel], Error>) -> Void) {
        if let hotels = hotels {
            completion(.success(hotels))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class HotelsListPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: HotelsListPresenter!
    var networkService: NetworkProviderProtocol!
    var router: RouterProtocol!
    var database = LocalStorageProvider()
    var hotels = [Hotel]()
    
    override func setUpWithError() throws {
        let nav = UINavigationController()
        let assembly = AssemblyModelBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }
    
    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccesHotel() {
        let hotel = Hotel(name: "Baz", address: "Bar", phone: "Foo", stars: 1, imageUrlString: "Bat", images: ["Ba","Bo"], description: "Bay")!
        hotels.append(hotel)
        
        view = MockView()
        networkService = MockNetworkService(hotels: hotels)
        presenter = HotelsListPresenter(view: view, networkProvider: networkService, database: database, router: router)
        
        var catchHotels: [Hotel]?
        
        networkService.getHotelList { result in
            switch result {
            case.success(let hotels):
                catchHotels = hotels
            case.failure(let error):
                print(error)
                
            }
        }
        XCTAssertNotEqual(catchHotels?.count, 0)
        XCTAssertEqual(catchHotels?.count, hotels.count)
    }
    
    func testGetFailureHotel() {
        let hotel = Hotel(name: "Baz", address: "Bar", phone: "Foo", stars: 1, imageUrlString: "Bat", images: ["Ba","Bo"], description: "Bay")!
        hotels.append(hotel)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = HotelsListPresenter(view: view, networkProvider: networkService, database: database, router: router)
        
        var catchError: Error?
        
        networkService.getHotelList { result in
            switch result {
            case.success(let hotels):
                print(hotels)
            case.failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }
}
