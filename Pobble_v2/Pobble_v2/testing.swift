import Foundation

struct CalendarEvent {
    let title: String
    let date: Date
}

class Calendar {
    var events: [CalendarEvent] = []
    
    func addEvent(title: String, date: Date) {
        let event = CalendarEvent(title: title, date: date)
        events.append(event)
    }
    
    func getEvents(forDate date: Date) -> [CalendarEvent] {
        let filteredEvents = events.filter { $0.date.isSameDay(as: date) }
        return filteredEvents
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}

// Usage example
let calendar = Calendar()

calendar.addEvent(title: "Meeting", date: Date())
calendar.addEvent(title: "Lunch", date: Date())

let todayEvents = calendar.getEvents(forDate: Date())
print(todayEvents)
