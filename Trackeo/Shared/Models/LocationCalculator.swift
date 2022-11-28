import Foundation

class LocationCalculator {
    static func calculateDistance(firstPoint: Location , secondPoint: Location) -> Double {
        let earthsRadius = 6371e3
        
        let firstLatitudeInRadian =  degreesToRadian(degrees: firstPoint.latitude)
        let secondLatitudeInRadian = degreesToRadian(degrees: secondPoint.latitude)
        
        let deltaLatitude = degreesToRadian(degrees: secondPoint.latitude - firstPoint.latitude)
        let deltaLongitude = degreesToRadian(degrees: secondPoint.longitude - firstPoint.longitude)
        
        let a = sin(deltaLatitude / 2) * sin(deltaLatitude / 2)
        + cos(firstLatitudeInRadian) * cos(secondLatitudeInRadian)
        * sin(deltaLongitude / 2) * sin(deltaLongitude / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        return earthsRadius * c
    }

    static func degreesToRadian(degrees : Double) -> Double {
        let pi = 3.1415926535
        return degrees * (pi / 180)
    }
}
