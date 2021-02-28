//
//  Current+Helper.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/3/21.
//

import Foundation

extension Current {
    var season : Season {
        //continue here to determine to correct limits for months
        if getMonth(dt: Date()) <= 2 || getMonth(dt: Date()) >= 12 {
            return Season.winter
        } else if getMonth(dt: Date()) >= 3 && getMonth(dt: Date()) <= 5 {
            return Season.spring
        } else if getMonth(dt: Date()) >= 6 && getMonth(dt: Date()) <= 8 {
            return Season.summer
        } else if getMonth(dt: Date()) >= 9 && getMonth(dt: Date()) <= 11{
            return Season.fall
        }
        return Season.spring
    }
}

func getMonth(dt : Date) -> Int {
    var monthDate = dt.description.prefix(7)
    monthDate = monthDate.suffix(2)
    return Int(monthDate) ?? 0
}
