//
//  Extensions.swift
//  GogoroMap
//
//  Created by 陳 冠禎 on 2017/8/9.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import UIKit
import StoreKit
import Foundation
import MapKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    class var lightBlue: UIColor {
        return UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
    class var lightGreen: UIColor {
        return UIColor.rgb(red: 45, green: 149, blue: 64)
    }
    class var heavyBlue: UIColor {
        return UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    class var grassGreen: UIColor {
        return UIColor.rgb(red: 85 , green: 177, blue: 114)
    }
    
    class var lightRed: UIColor {
        return UIColor.rgb(red: 218 , green: 52, blue: 53)
    }
    
}



extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil, right:  NSLayoutXAxisAnchor? = nil,
                topPadding: CGFloat = 0, leftPadding: CGFloat = 0,
                bottomPadding: CGFloat = 0, rightPadding: CGFloat = 0,
                width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension Date {
    static let today: String = {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: date)
        return dateString
    } ()
}


extension Double {
    var km: Double {
        return Double(String(format:"%.1f", self / 1000)) ?? 0
    }
    
    var format: Double {
        return Double(String(format:"%.2f", self)) ?? 0
    }

    var percentage: String {
        return String(format: "%.1f", self * 100)
    }
    var convertToHMS: String {
        
        let minutes = Int(self.truncatingRemainder(dividingBy: 3600) / 60)
        let hours = Int(self / 3600)
        
        var result: String = ""
        
        result += hours > 0 ? "\(hours) 小時 " : ""
        result += "\(minutes + 1) 分鐘 "
        return result
    }

}


extension Bundle {
    static var id: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}




extension SKProduct {
    func localizedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price) ?? "\(price)"
    }
}


enum DeviceMode: String {
    case iPhoneX
    case others
}

extension UIDevice {
    static var isiPhoneX: Bool {
        let heightOfiPhoneX: CGFloat = 812
        return modelName == .iPhoneX || UIScreen.main.bounds.height == heightOfiPhoneX
    }
    
    static var modelName: DeviceMode {
       
        var systemIfo = utsname()
        uname(&systemIfo)
        let machineMirror = Mirror(reflecting: systemIfo.machine)
        
        let identifier = machineMirror.children.reduce("") { (identifier, element)  in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        
        switch identifier {
        case "iPhone10,3", "iPhone10,6": return .iPhoneX
        default: return .others
        }
    }
}

extension MKMapPoint {
    var centerOfScreen: MKMapPoint {
        let factorOfPixelToMapPoint = 12000.0 / 320
        let offsetCenterX: Double = Double(UIScreen.main.bounds.width / 2) * factorOfPixelToMapPoint
        let offsetCenterY: Double = Double(UIScreen.main.bounds.height / 2) * factorOfPixelToMapPoint
        
        return MKMapPoint(x: x - offsetCenterX, y: y - offsetCenterY)
    }
}
