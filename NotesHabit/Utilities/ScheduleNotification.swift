import UserNotifications

func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if let error = error {
            print("Error requesting notification permissions: \(error)")
        } else if granted {
            print("Notification permissions granted.")
        } else {
            print("Notification permissions denied.")
        }
    }
}

func scheduleHabitNotifications(for habit: HabitModel) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Remove any existing notifications for this habit
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [habit.id.uuidString])
    
    guard habit.isReminder, let reminderTime = habit.time else { return }
    
    let content = UNMutableNotificationContent()
    content.title = "Habit Reminder"
    content.body = "Time to work on your habit: \(habit.title)"
    content.sound = .default
    
    let calendar = Calendar.current
    
    for day in habit.days {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: reminderTime)
        dateComponents.minute = calendar.component(.minute, from: reminderTime)
        dateComponents.weekday = day + 1  // weekday is 1-indexed: 1 for Sunday, 2 for Monday, etc.
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(habit.id.uuidString)-\(day)", content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
