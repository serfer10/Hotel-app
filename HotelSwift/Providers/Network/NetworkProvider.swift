

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkProviderProtocol {
    func getHotelList(completion: @escaping (Result<[Hotel], Error>) -> Void)
}

class NetworkProvider: NetworkProviderProtocol {
    let baseUrl = "https://raw.githubusercontent.com/Sinweaver/HotelsJson/master/"
    
    func getHotelList(completion: @escaping (Result<[Hotel], Error>) -> Void) {
        AF.request(baseUrl + "hotelsList.json").response { response in
            switch response.result {
            case .success(let value):
                guard let jsonData = value, let hotelJsons = JSON(jsonData).array else {
                    let error = NSError(domain:"", code:-1, userInfo:[NSLocalizedDescriptionKey: "Не удалось загрузить даные"])
                    completion(.failure(error))
                    return
                }
                let hotelList = hotelJsons.compactMap { Hotel(json: $0, baseUrl: self.baseUrl) }
                completion(.success(hotelList))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
