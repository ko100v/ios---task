//
//  DateManager.swift
//  YourLocal
//
//  Created by Dimitar Kostov on 1/23/16.
//  Copyright (c) 2015 158ltd.com. All rights reserved.
//

import Foundation

/**
Enumeration for properly set date format

- Time:         Time -> 'at' 15:10
- TimeAndMonth: August 'at' 15:10
*/
enum DateFormatStyle {
    case Time
    case TimeAndMonth
}

// Use cases

// #################################################################################################################

private let FEW_SECONDS_AGO: String = "1s"

private let LESS_THAN_MINUTE_AGO: String = "1m"

private let ABOUT_A_MINUTE_AGO: String = "1m"

/**
Return String 'MINUTES VALUE' time ago

- parameter MINUTES: Int value

- returns: String
*/
private func MINUTES_AGO(MINUTES MINUTES: Int) -> String { return "\(MINUTES)m" }

private let LESS_THAN_HOUR_AGO: String = "30m"

private let ABOUT_AN_HOUR_AGO: String = "1h"

/**
Return String 'HOUR VALUE' time ago

- parameter HOURS: HOURS Int Value

- returns: String
*/
private func HOURS_AGO(HOURS HOURS: Int) -> String { return "\(HOURS)h" }

private let YESTERDAY: String = "Yesterday "

// #################################################################################################################

class DateManager: NSDate {
    
    // MARK: - Public API
    
    /*
    This method create and return NSDate object by given string form rest api
    */
    internal class func convertStringToDate(dateString dateString: String?) -> NSDate {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        if dateString != nil {
            date = dateFormatter.dateFromString(dateString!)!
        }
        return date
    }
    
    /*
    By given date timeInWordsAgoFromDate returs friendly represented date in words like a minte ago, about an hour ago, 5 hours ago till the end of the day, than if is the next day it will return "Yesterday at 'time value'", else if is more days ahead it will return "'month value' at 'time value'" example August at 15:55
    */
    internal class func timeInWordsAgoFromDate(date date: NSDate) -> String {
        
        let newDate = NSCalendar.currentCalendar().dateByAddingUnit(.Hour, value: 3, toDate: date, options: [])
        
        let dateComponents = DateManager.getComponentsFromDate(date: newDate!)
        let currentComponents = DateManager.getComponentsFromDate(date: NSDate())
        
        if currentComponents.day == dateComponents.day { // SAME DAY
            if currentComponents.hour == dateComponents.hour { // SAME HOUR
                if currentComponents.minute == dateComponents.minute {
                    return LESS_THAN_MINUTE_AGO // RETURN "LESS THAN MINUTE AGO"
                } else if currentComponents.minute - 1 == dateComponents.minute {
                    return ABOUT_A_MINUTE_AGO // RETURN "ABOUT A MINUTE AGO"
                } else if currentComponents.minute > dateComponents.minute {
                    if (currentComponents.minute - dateComponents.minute) > 30 {
                        return LESS_THAN_HOUR_AGO // RETURN "LESS THAN HOUR AGO"
                    } else {
                        return MINUTES_AGO(MINUTES: currentComponents.minute - dateComponents.minute) // RETURN 'MINUTES VALUE' MINUTES AGO
                    }
                }
            } else if currentComponents.hour - 1 == dateComponents.hour { // NEXT HOUR
                return ABOUT_AN_HOUR_AGO // RETURN "ABOUT AN HOUR AGO"
            } else if currentComponents.hour > dateComponents.hour {
                return HOURS_AGO(HOURS: currentComponents.hour - dateComponents.hour) // RETURN 'HOUR VALUE' HOURS AGO
            }
            
        } else if currentComponents.day - 1 == dateComponents.day { // NEXT DAY
            return "1d"
        } else {
            return "\(abs(dateComponents.day - currentComponents.day))d"
        }
        return ""
    }
    
    // MARK: - 
    // MARK: Private API
    
    /**
    This method returns time in words by given date -> NSDate and dateFormatStyle -> DateFormatStyle
    
    - parameter date:  NSDate
    - parameter style: DateFormatStyle
    
    - returns: String with Time from given date
    */
    private class func getTimeInWordsFromDate(date date: NSDate, forDateFormatStyle style: DateFormatStyle) -> String {
        
        // Create NSDateFormatter
        let dateFormatter = NSDateFormatter()
        // Create dateFormat String placeholder
        var dateFormatString: String?
        
        // Set placeholder dateFormatStyle
        switch style {
        case .Time: dateFormatString = "'at' HH:mm"
        case .TimeAndMonth: dateFormatString = "MMMM dd 'at' HH:mm"
        }
        
        // Set style
        dateFormatter.dateFormat = dateFormatString!
        
        // Return Time in words
        return dateFormatter.stringFromDate(date)
    }
    
    /// This method return array of NSCalendarUnits
    private class func calendarUnits() -> NSCalendarUnit {
        
        return NSCalendarUnit.Day.union(NSCalendarUnit.WeekOfYear).union(NSCalendarUnit.Month).union(NSCalendarUnit.Year).union(NSCalendarUnit.Hour).union(NSCalendarUnit.Minute).union(NSCalendarUnit.Second)
    }
    
    /// This method returns date components as Year, Week, Day, Hour, Minute, Second etc.. by given NSDate
    private class func getComponentsFromDate(date date: NSDate) -> NSDateComponents {
        
        return NSCalendar.currentCalendar().components(DateManager.calendarUnits(), fromDate: date)
    }
    
    /**
    Method to determine count of days in each mounth depending on the year
    
    - parameter year: The year for which the days will be counted
    */
    internal class func checkDaysInMonthsInYaer(year: Int) -> [Int] {
        
        var daysInMonth = [Int]()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.dateFromString("\(year)-01-02")!
        
        let components: NSDateComponents = calendar.components(NSCalendarUnit.Year, fromDate: today)
        let months = calendar.rangeOfUnit(NSCalendarUnit.Month,
            inUnit:NSCalendarUnit.Year,
            forDate:today).length
        
        for index in 1.stride(through: months, by: +1) {
            components.month = index
            let month = calendar.dateFromComponents(components)
            
            daysInMonth.append(calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: month!).length)
        }
        
        return daysInMonth
    }
    
    /**
    Method to return a range of years depending on the current one
    */
    
    internal class func getYearFromTodayDate() -> (maximumBirthYear: Int,rangeOfYears: [Int]) {
        var years = [Int]()
        
        let flags: NSCalendarUnit = [.Day, .Month, .Year]
        let date = NSDate()
        let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
        
        let year = components.year
        
        for index in 0..<84 {
            years.append((year - 16) - index)
        }
        
        return (year - 16, years)
        
    }
}
