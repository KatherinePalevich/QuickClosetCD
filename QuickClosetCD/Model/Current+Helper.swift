//
//  Current+Helper.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/3/21.
//

import Foundation

extension Current.Main {
    var season : Season {
        if temp <= 278 {
            return Season.winter
        } else if temp > 284 && temp <= 289 {
            return Season.spring
        } else if temp > 289 {
            return Season.summer
        } else if temp > 278 && temp <= 284{
            return Season.fall
        }
        return Season.spring
    }
}
