//
//  CalendarModel.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import Foundation
protocol CalendarEvent {
    var title: String? { get set }
    var day: Int? { get set }
    var startHour: Int? { get set }
    var durationInHours: Int? { get set }
}

class CalendarModel: CalendarEvent {
    var title: String?
    var day: Int?
    var startHour: Int?
    var durationInHours: Int?
    
    /// 类方法
    ///
    /// - Returns: self
    class func randomEvent() -> CalendarModel {
        let randonID = arc4random_uniform(10000)
        let title = "Event #\(Int(randonID))"
        let randomDay = arc4random_uniform(7)
        let randomStartHour = arc4random_uniform(20)
        let randomDuration = arc4random_uniform(5) + 1
        
        return CalendarModel(withTitle: title, day: Int(randomDay), startHour: Int(randomStartHour), durationInHours: Int(randomDuration))
    }
    
    /// 自定义构造器
    ///
    /// - Parameters:
    ///   - title: title
    ///   - day: day
    ///   - startHour: start hour
    ///   - durationInHours: duration in hours
    init(withTitle title: String, day: Int?, startHour: Int, durationInHours: Int) {
        self.title = title
        self.day = day
        self.startHour = startHour
        self.durationInHours = durationInHours
    }
    
    
}
