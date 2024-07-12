import SwiftUI
import SwiftData

struct TopBarCalendar: View {
    @State private var selectedDate = Date()
    @State private var currentWeekOffset = 0
    @State private var showDatePicker = false
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM yyyy"
        return formatter
    }()
    
    // Sample goals data
    @State private var goalsContent: [HabitModel] = [
        HabitModel(title: "Morning Routines", body: "Personal", days: [2, 4, 6], startDate: Date(), emoji: "🌅", notes: [], streak: 5, lastLog: Date()),
        HabitModel(title: "SwiftUI Learn", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "📚", notes: [], time: Date(), streak: 10, lastLog: Date()),
        HabitModel(title: "Learn Figma", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "🎨", notes: [], time: Date(), streak: 10, lastLog: Date())
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                weekView
                
                Text(dateFormatter.string(from: selectedDate))
                    .font(.system(size: 18))
                    .padding(.bottom, 6)
                
                Divider()
                    .padding(.bottom, 6)
                
                if let dayGoals = goalsForSelectedDate() {
                    List {
                        ForEach(dayGoals) { goal in
                            if goal.deleteAt == nil {
                                GoalCard(goal: goal)
                                    .padding(.horizontal, -10)
                                    .swipeActions(edge: .leading) {
                                        Button {
                                            // Add favorite action here
                                        } label: {
                                            Image(systemName: "heart.fill")
                                        }
                                        .tint(.red)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            // Add delete action here
                                            goal.deleteAt = Date()
                                        } label: {
                                            Image(systemName: "trash.fill")
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.visible)
                    .background(.white)
                } else {
                    Text("No activities for this date")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .background(Color(.systemBackground))
            
            if showDatePicker {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showDatePicker = false
                    }
                
                DatePickerView(selectedDate: $selectedDate) { newDate in
                    selectedDate = newDate
                    showDatePicker = false
                }
                .frame(width: 350)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .offset(y: -120)
            }
        }
    }
    
    var weekView: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Calendar")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.red)
                
                Spacer()
                
                HStack(spacing: 25) {
                    Button(action: {
                        showDatePicker = true
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        // Handle add action
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                    }
                }
                .font(.system(size: 22))
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                ForEach(0..<7) { index in
                    VStack {
                        Text(shortWeekdayString(from: index))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Circle()
                            .fill(isDateSelected(index: index) ? Color.red : Color.clear)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text(dayString(from: index))
                                    .foregroundColor(isDateSelected(index: index) ? .white : .primary)
                            )
                            .onTapGesture {
                                selectDate(index: index)
                            }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            currentWeekOffset += 1
                        } else if value.translation.width > 0 {
                            currentWeekOffset -= 1
                        }
                    }
            )
        }
    }
    
    func shortWeekdayString(from index: Int) -> String {
        let date = dateForIndex(index)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    
    func dayString(from index: Int) -> String {
        let date = dateForIndex(index)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func isDateSelected(index: Int) -> Bool {
        let date = dateForIndex(index)
        return calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    func selectDate(index: Int) {
        let date = dateForIndex(index)
        selectedDate = date
    }
    
    func dateForIndex(_ index: Int) -> Date {
        let startOfWeek = calendar.date(byAdding: .day, value: currentWeekOffset * 7, to: getStartOfWeek(for: selectedDate))!
        return calendar.date(byAdding: .day, value: index, to: startOfWeek)!
    }
    
    func getStartOfWeek(for date: Date) -> Date {
        var startOfWeek: Date = Date()
        var interval: TimeInterval = 0
        if calendar.dateInterval(of: .weekOfYear, start: &startOfWeek, interval: &interval, for: date) {
            return startOfWeek
        } else {
            return date
        }
    }
    
    func updateWeekForSelectedDate() {
        let startOfWeek = getStartOfWeek(for: selectedDate)
        let daysBetween = calendar.dateComponents([.day], from: startOfWeek, to: selectedDate).day ?? 0
        currentWeekOffset = daysBetween / 7
    }
    
    func goalsForSelectedDate() -> [HabitModel]? {
        let selectedDayOfWeek = calendar.component(.weekday, from: selectedDate)
        return goalsContent.filter { goal in
            guard goal.days.contains(selectedDayOfWeek) else { return false }
            return calendar.compare(selectedDate, to: goal.startDate, toGranularity: .day) != .orderedAscending
        }
    }
}


struct CalendarView: View {
    var body: some View {
        TopBarCalendar()
    }
}

#Preview {
    do
    {
        var config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return CalendarView()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}

