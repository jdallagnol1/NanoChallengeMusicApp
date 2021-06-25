//
//  Helper.swift
//  NanoChallengeMusicApp
//
//  Created by João Vitor Dall Agnol Fernandes on 22/06/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60

        return String(format: "%0.2dmin %0.2ds",minutes,seconds)

    }
}

extension Date {

    func dateFormatWithSuffix() -> String {
        return "dd \(self.daySuffix()) MMMM yyyy"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
