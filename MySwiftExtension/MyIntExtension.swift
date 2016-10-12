//
//  MyIntExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/16.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation

public extension Int {
    
    /// 检查是不是偶数
    ///
    /// :return 偶数 true
    public var isEven: Bool {
        get {
            return self % 2 == 0
        }
    }
    
    /// 检查是不是奇数
    ///
    /// :return 奇数 true
    public var isOdd: Bool {
        get {
            return self % 2 == 1
        }
    }
    
    /// 根据ASCII获取对应的字符，注意不要越界
    ///
    /// :return ASCII字符
    public var char: Character {
        get {
            return Character(UnicodeScalar(self))
        }
    }
    
    /// 分开int值成一个数组
    ///
    /// :return Bool whether int is odd
    public func digits() -> [Int] {
        var digits: [Int] = []
        var selfCopy = self
        while selfCopy > 0 {
            digits << (selfCopy % 10)
            selfCopy = (selfCopy / 10)
        }
        return Array(digits.reverse())
    }
    
    /// 返回下一个值
    ///
    /// :return next
    public func next() -> Int {
        return self + 1
    }
    
    /// 返回前一个值
    ///
    /// :return before int
    public func before() -> Int {
        return self - 1
    }
    
    var toNumber_64Bit : NSNumber{
        let self64 = Int64(self)
        return NSNumber(longLong: self64)
    }
    
    var toString : String{
        return String(self)
    }
    ///0为假 1为真
    func toBool () ->Bool? {
        switch self {
        case 0:
            return false
        case 1:
            return true
        default:
            return nil
        }
    }
    
    
    
    
    private func mathForUnit(unit: NSCalendarUnit) -> CalendarMath {
        return CalendarMath(unit: unit, value: self)
    }
    
    var seconds: CalendarMath {
        return mathForUnit(.Second)
    }
    
    var second: CalendarMath {
        return seconds
    }
    
    var minutes: CalendarMath {
        return mathForUnit(.Minute)
    }
    
    var minute: CalendarMath {
        return minutes
    }
    
    var hours: CalendarMath {
        return mathForUnit(.Hour)
    }
    
    var hour: CalendarMath {
        return hours
    }
    
    var days: CalendarMath {
        return mathForUnit(.Day)
    }
    
    var day: CalendarMath {
        return days
    }
    
    var weeks: CalendarMath {
        return mathForUnit(.WeekOfYear)
    }
    
    var week: CalendarMath {
        return weeks
    }
    
    var months: CalendarMath {
        return mathForUnit(.Month)
    }
    
    var month: CalendarMath {
        return months
    }
    
    var years: CalendarMath {
        return mathForUnit(.Year)
    }
    
    var year: CalendarMath {
        return years
    }
    
    struct CalendarMath {
        private let unit: NSCalendarUnit
        private let value: Int
        private var calendar: NSCalendar {
            return NSCalendar.autoupdatingCurrentCalendar()
        }
        
        private init(unit: NSCalendarUnit, value: Int) {
            self.unit = unit
            self.value = value
        }
        
        private func generateComponents(modifer: (Int) -> (Int) = (+)) -> NSDateComponents {
            let components = NSDateComponents()
            components.setValue(modifer(value), forComponent: unit)
            return components
        }
        
        public func from(date: NSDate) -> NSDate? {
            return calendar.dateByAddingComponents(generateComponents(), toDate: date, options: [])
        }
        
        public var fromNow: NSDate? {
            return from(NSDate())
        }
        
        public func before(date: NSDate) -> NSDate? {
            return calendar.dateByAddingComponents(generateComponents(-), toDate: date, options: [])
        }
        
        public var ago: NSDate? {
            return before(NSDate())
        }
    }
    
    /// Invoke a callback n times
    ///
    /// :param callback The function to invoke that accepts the index
    public func times(callback: (Int) -> ()) {
        (0..<self).eachWithIndex { callback($0) }
    }
    
    /// Invoke a callback n times
    ///
    /// :param callback The function to invoke
    public func times(function: () -> ()) {
        self.times { (index: Int) -> () in
            function()
        }
    }
    
    /// Invoke the callback from int up to and including limit
    ///
    /// :params limit the max value to iterate upto
    /// :params callback to invoke
    public func upTo(limit: Int, callback: () -> ()) {
        (self...limit).each { callback() }
    }
    
    /// Invoke the callback from int up to and including limit passing the index
    ///
    /// :params limit the max value to iterate upto
    /// :params callback to invoke
    public func upTo(limit: Int, callback: (Int) -> ()) {
        (self...limit).eachWithIndex { callback($0) }
    }
    
    /// Invoke the callback from int down to and including limit
    ///
    /// :params limit the min value to iterate upto
    /// :params callback to invoke
    public func downTo(limit: Int, callback: () -> ()) {
        var selfCopy = self
        while selfCopy-- >= limit {
            callback()
        }
    }
    
    /// Invoke the callback from int down to and including limit passing the index
    ///
    /// :params limit the min value to iterate upto
    /// :params callback to invoke
    public func downTo(limit: Int, callback: (Int) -> ()) {
        var selfCopy = self
        while selfCopy >= limit {
            callback(selfCopy--)
        }
    }
    
    /// GCD metod return greatest common denominator with number passed
    ///
    /// :param number
    /// :return Greatest common denominator
    public func gcd(n: Int) -> Int {
        return $.gcd(self, n)
    }
    
    /// LCM method return least common multiple with number passed
    ///
    /// :param number
    /// :return Least common multiple
    public func lcm(n: Int) -> Int {
        return $.lcm(self, n)
    }
    
    /// Returns random number from 0 upto but not including value of integer
    ///
    /// :return Random number
    public func random() -> Int {
        return $.random(self)
    }
    
    /// Returns Factorial of integer
    ///
    /// :return factorial
    public func factorial() -> Int {
        return $.factorial(self)
    }
    
    /// Returns true if i is in closed interval
    ///
    /// :param i to check if it is in interval
    /// :param interval to check in
    /// :return true if it is in interval otherwise false
    public func isIn(interval: ClosedInterval<Int>) -> Bool {
        return $.it(self, isIn: interval)
    }
    
    /// Returns true if i is in half open interval
    ///
    /// :param i to check if it is in interval
    /// :param interval to check in
    /// :return true if it is in interval otherwise false
    public func isIn(interval: HalfOpenInterval<Int>) -> Bool {
        return $.it(self, isIn: interval)
    }
    
    /// Returns true if i is in range
    ///
    /// :param i to check if it is in range
    /// :param interval to check in
    /// :return true if it is in interval otherwise false
    public func isIn(interval: Range<Int>) -> Bool {
        return $.it(self, isIn: interval)
    }
    
}

public extension Int64{
    
    var toNumber_64Bit : NSNumber{
        return NSNumber(longLong: self)
    }
    
    var toString : String{
        return String(self)
    }
    
    var toDate : NSDate{
        let interval : NSTimeInterval = Double(self) / 1000
        return NSDate(timeIntervalSince1970:interval)
    }
}