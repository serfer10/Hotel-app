

import Foundation
import RealmSwift

class LocalStorageProvider {
    let realm = try! Realm()
    
    func saveHotels(hotels: [Hotel]) {
        removeAllHotels()
        let objects = convert(hotels)
        saveHolels(objects)
    }
    
    private func removeAllHotels() {
        let result = realm.objects(HotelObject.self)
        try! realm.write {
            realm.delete(result)
        }
    }
    
    private func saveHolels(_ objects: [HotelObject]) {
        try! realm.write {
            realm.add(objects)
        }
    }
    
    private func convert(_ hotel: Hotel) -> HotelObject {
        let object = HotelObject()
        object.name = hotel.name
        object.address = hotel.address
        object.descriptionInfo = hotel.description
        object.phone = hotel.phone
        object.stars = hotel.stars
        object.imageUrl = hotel.imageUrl.absoluteString
        object.images.append(objectsIn: hotel.images)
        return object
    }
    
    private func convert(_ hotels: [Hotel]) -> [HotelObject] {
        var data: [HotelObject] = []
        for hotel in hotels {
            let object = convert(hotel)
            data.append(object)
        }
        return data
    }
    
    func getAllHotels() -> [Hotel] {
        let hotelsObjects = realm.objects(HotelObject.self)
        var hotels: [Hotel] = []
        for object in hotelsObjects {
            let name = object.name
            let address = object.address
            let descriptionInfo = object.descriptionInfo
            let phone = object.phone
            let star = object.stars
            let images = Array(object.images)
            if let data = Hotel(name: name,
                                address: address,
                                phone: phone,
                                stars: star,
                                imageUrlString: object.imageUrl,
                                images: images,
                                description: descriptionInfo) {
                hotels.append(data)
            }
        }
        return hotels
    }
}

