

import Foundation
import SwiftyJSON

struct Hotel {
    let name: String
    let address : String
    let phone: String
    let stars: Int
    let imageUrl: URL
    let images : [String]
    let description : String
    
    enum JSONKey: String {
        case name, address, stars, phone, images, description
    }
    
    init?(json: JSON, baseUrl: String) {
        guard let name = json[JSONKey.name.rawValue].string,
              let address = json[JSONKey.address.rawValue].string,
              let stars = json[JSONKey.stars.rawValue].int,
              let phone = json[JSONKey.phone.rawValue].string,
              let imageNames = json[JSONKey.images.rawValue].array,
              let imageUrlString = imageNames.first?.string,
              let imageUrl = URL(string: baseUrl + imageUrlString),
              let description = json[JSONKey.description.rawValue].string  else {
            return nil
        }
        self.name = name
        self.address = address
        self.phone = phone
        self.stars = stars
        self.imageUrl = imageUrl
        self.images = imageNames.map { baseUrl + $0.stringValue }
        self.description = description
    }
    
    init?(name: String,
          address: String,
          phone: String,
          stars: Int,
          imageUrlString: String,
          images: [String],
          description: String) {
        
        guard let imageUrl = URL(string: imageUrlString) else {
            return nil
        }
        self.name = name
        self.address = address
        self.phone = phone
        self.stars = stars
        self.imageUrl = imageUrl
        self.images = images
        self.description = description
    }
}
