import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    var onDateChange: (Date) -> Void
    
    var body: some View {
        DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .onChange(of: selectedDate) { newValue in
                onDateChange(newValue)
            }
            .padding()
            .accentColor(.red)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var selectedDate = Date()

    static var previews: some View {
        DatePickerView(selectedDate: $selectedDate) { newDate in
            print("Date changed to \(newDate)")
        }
    }
}

//import SwiftUI
//
//struct CustomDatePickerView: View {
//    @Binding var selectedDate: Date
//    @State private var showMonthYearPicker = false
//    var onDateChange: (Date) -> Void
//
//    private let calendar = Calendar.current
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
//
//    var body: some View {
//        VStack {
////            HStack {
////                Button(action: {
////                    showMonthYearPicker.toggle()
////                }) {
////                    Text(dateFormatter.string(from: selectedDate))
////                        .foregroundColor(.red)
////                    Image(systemName: "chevron.right")
////                        .foregroundColor(.red)
////                }
////                .padding()
////
////                Spacer()
////            }
//
//            if showMonthYearPicker {
//                MonthYearPickerView(selectedDate: $selectedDate, onDateChange: { newDate in
//                    selectedDate = newDate
//                    showMonthYearPicker = false
//                    onDateChange(newDate)
//                })
//                .padding()
//            }
//
//            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .labelsHidden()
//                .onChange(of: selectedDate) { newValue in
//                    if !showMonthYearPicker {
//                        onDateChange(newValue)
//                    } else {
//                        showMonthYearPicker = false
//                        onDateChange(newValue)
//                    }
//                }
//                .padding()
//                .accentColor(.red)
//        }
//    }
//}
//
//struct MonthYearPickerView: View {
//    @Binding var selectedDate: Date
//    var onDateChange: (Date) -> Void
//
//    private let calendar = Calendar.current
//    private var months: [String] {
//        let formatter = DateFormatter()
//        return formatter.monthSymbols
//    }
//    private var years: [Int] {
//        let currentYear = calendar.component(.year, from: Date())
//        return Array(currentYear-10...currentYear+10)
//    }
//
//    @State private var selectedMonth: Int
//    @State private var selectedYear: Int
//
//    init(selectedDate: Binding<Date>, onDateChange: @escaping (Date) -> Void) {
//        _selectedDate = selectedDate
//        self.onDateChange = onDateChange
//        let calendar = Calendar.current
//        _selectedMonth = State(initialValue: calendar.component(.month, from: selectedDate.wrappedValue) - 1)
//        _selectedYear = State(initialValue: calendar.component(.year, from: selectedDate.wrappedValue))
//    }
//
//    var body: some View {
//        VStack {
//            HStack {
//                Picker("Month", selection: $selectedMonth) {
//                    ForEach(0..<months.count, id: \.self) { index in
//                        Text(self.months[index]).tag(index)
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .frame(width: 150)
//
//                Picker("Year", selection: $selectedYear) {
//                    ForEach(years, id: \.self) { year in
//                        Text(String(year)).tag(year)
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .frame(width: 150)
//            }
//
//            Button(action: {
//                let components = DateComponents(year: selectedYear, month: selectedMonth + 1)
//                if let newDate = calendar.date(from: components) {
//                    onDateChange(newDate)
//                }
//            }) {
//                Text("Select")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.red)
//                    .cornerRadius(8)
//            }
//        }
//    }
//}
//
//struct CustomDatePickerView_Previews: PreviewProvider {
//    @State static var selectedDate = Date()
//
//    static var previews: some View {
//        CustomDatePickerView(selectedDate: $selectedDate) { newDate in
//            print("Date changed to \(newDate)")
//        }
//    }
//}
