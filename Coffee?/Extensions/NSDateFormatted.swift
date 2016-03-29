//
//  NSDateFormatted.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/29/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import Foundation

extension NSDate {
    var formatted:String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/M/yyyy, H:mm"
        return formatter.stringFromDate(self)
    }
    func formattedWith(format:String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
}
