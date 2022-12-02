import Foundation

class LocationCalculator {
    static func calculateDistance(firstPoint: Location , secondPoint: Location) -> Double {
        let earthsRadius = 6371e3
        
        let firstLatitudeInRadian =  degreesToRadians(degrees: firstPoint.latitude)
        let secondLatitudeInRadian = degreesToRadians(degrees: secondPoint.latitude)
        
        let deltaLatitude = degreesToRadians(degrees: secondPoint.latitude - firstPoint.latitude)
        let deltaLongitude = degreesToRadians(degrees: secondPoint.longitude - firstPoint.longitude)
        
        let a = sin(deltaLatitude / 2) * sin(deltaLatitude / 2)
        + cos(firstLatitudeInRadian) * cos(secondLatitudeInRadian)
        * sin(deltaLongitude / 2) * sin(deltaLongitude / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        return earthsRadius * c
    }
    
    static func getBearing(currentLocation: Location, trackerLocation: Location) -> Double {
        let deltaL = trackerLocation.longitude.radians - currentLocation.longitude.radians
        let thetaB = trackerLocation.latitude.radians
        let thetaA = currentLocation.latitude.radians

        let x = cos(thetaB) * sin(deltaL)
        let y = cos(thetaA) * sin(thetaB) - sin(thetaA) * cos(thetaB) * cos(deltaL)
        let bearing = atan2(x, y)
        return bearing.degrees
    }

    static func degreesToRadians(degrees : Double) -> Double {
        let pi = 3.1415926535
        return degrees * (pi / 180)
    }
}
