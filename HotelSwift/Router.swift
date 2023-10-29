

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(hotels: Hotel)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let mainViewComtroller = assemblyBuilder.createHotelListModule(router: self)
        navigationController.viewControllers = [mainViewComtroller]
    }
    
    func showDetail(hotels: Hotel) {
        let detailViewComtroller = assemblyBuilder.createDetailModule(hotels: hotels, router: self)
        navigationController.pushViewController(detailViewComtroller, animated: true)
    }
}



