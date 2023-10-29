

import Foundation
import RealmSwift

class HotelObject : Object {
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var stars: Int = 0
    @objc dynamic var imageUrl = ""
    var images = List<String>()
    @objc dynamic var descriptionInfo : String = ""
    
    override class func primaryKey() -> String? {
       return "imageUrl"
    }
}
