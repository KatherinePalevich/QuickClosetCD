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
        if getMonth(dt: dt) <= 278 {
            return Season.winter
        } else if getMonth(dt: dt) > 284 && getMonth(dt: dt) <= 289 {
            return Season.spring
        } else if getMonth(dt: dt) > 289 {
            return Season.summer
        } else if getMonth(dt: dt) > 278 && getMonth(dt: dt) <= 284{
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
