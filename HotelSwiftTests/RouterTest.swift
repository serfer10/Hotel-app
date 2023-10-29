

import XCTest
@testable import HotelSwift

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblyModelBuilder()

    let hotels = Hotel(name: "Baz", address: "Bar", phone: "Foo", stars: 1, imageUrlString: "Ta", images: ["Ba", "Bo"], description: "Va")
    
    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }
    
    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(hotels: hotels!)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailHotelViewController)
    }
}
