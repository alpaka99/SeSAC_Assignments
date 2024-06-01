//
//  Chat.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

//채팅 화면에서 사용할 데이터 구조체
import Foundation

struct StaticDateFormatter {
    static var shared: DateFormatter = DateFormatter()
    
    func convertStringToDate(_ stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        if let result = dateFormatter.date(from: stringDate) {
            return result
        }
        return Date.now
    }
    
    func formatDateToString(_ dateType: DateType) {
        switch dateType {
        case .yearMonthDay:
            break
        case .hourMinute:
            break
        }
    }
}

enum DateType {
    case yearMonthDay
    case hourMinute
}

struct Chat {
    let user: User
    let date: String
    let message: String
    
//    "2024-06-12 21:30",
    // MARK: DateFormatter 정적 프로퍼티로 분리하기
    var convertedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        if let result = dateFormatter.date(from: date) {
            return result
        }
        return Date.now
    }
    
    var formattedDate: String {
        let calander = Calendar.current
        let components = calander.dateComponents([.year, .month, .day], from: convertedDate)
        return "No date data"
    }
    
//    "2024-06-12 21:30"
    var formattedTime: String {
        if let dateComponets = date.components(separatedBy: " ").last {
            let yyDDmm = dateComponets.components(separatedBy: "")
            return yyDDmm.joined(separator: ".")
        }
        return "No date data"
    }
}
