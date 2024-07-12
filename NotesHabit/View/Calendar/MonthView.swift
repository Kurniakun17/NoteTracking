import SwiftUI

struct InfiniteVerticalCalendarView: View {
    @State private var selectedDate = Date()
    @State private var months: [Date] = []
    @State private var currentMonthOffset = 0
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    init() {
        let initialMonth = calendar.date(byAdding: .month, value: -6, to: Date())!
        _months = State(initialValue: Array(-6...6).compactMap {
            calendar.date(byAdding: .month, value: $0, to: initialMonth)
        })
    }
    
    var body: some View {
        VStack {
            Text(dateFormatter.string(from: selectedDate))
                .font(.headline)
                .padding(.bottom)
            
            ScrollView {
                LazyVStack {
                    ForEach(months, id: \.self) { month in
                        MonthView(selectedDate: $selectedDate, monthDate: month)
                            .padding(.bottom, 10)
                            .onAppear {
                                if month == months.first {
                                    loadPreviousMonths()
                                }
                                if month == months.last {
                                    loadNextMonths()
                                }
                            }
                    }
                }
            }
        }
    }
    
    private func loadPreviousMonths() {
        guard let firstMonth = months.first else { return }
        let newMonths = (1...6).compactMap {
            calendar.date(byAdding: .month, value: -$0, to: firstMonth)
        }
        months.insert(contentsOf: newMonths, at: 0)
    }
    
    private func loadNextMonths() {
        guard let lastMonth = months.last else { return }
        let newMonths = (1...6).compactMap {
            calendar.date(byAdding: .month, value: $0, to: lastMonth)
        }
        months.append(contentsOf: newMonths)
    }
}

struct MonthView: View {
    @Binding var selectedDate: Date
    let monthDate: Date
    let calendar = Calendar.current
    
    var body: some View {
        let monthString = DateFormatter().monthSymbols[calendar.component(.month, from: monthDate) - 1]
        let yearString = String(calendar.component(.year, from: monthDate))
        
        VStack {
            HStack {
                Text("\(monthString) \(yearString)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(daysInMonth(for: monthDate), id: \.self) { date in
                    Text("\(calendar.component(.day, from: date))")
                        .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : .primary)
                        .frame(width: 40, height: 40)
                        .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.red : Color.clear)
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
        }
        .padding(.vertical)
    }
    
    func daysInMonth(for date: Date) -> [Date] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.map { day -> Date in
            let components = DateComponents(year: calendar.component(.year, from: date),
                                            month: calendar.component(.month, from: date),
                                            day: day)
            return calendar.date(from: components)!
        }
    }
}

struct ContentView2: View {
    var body: some View {
        InfiniteVerticalCalendarView()
    }
}

#Preview {
    ContentView2()
}
