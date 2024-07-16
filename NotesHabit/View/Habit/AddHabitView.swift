import SwiftData
import SwiftUI

struct AddHabitView: View {
    @State private var habitTitle: String = ""
    @State private var emoji: String = ""
    @State private var description: String = ""
    @State private var reminderOn: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var selectedTime: Date = .init()
    @State private var selectedDate: Date = .init()
    @State private var selectedDays: Set<Int> = []
    @EnvironmentObject var habitViewModel: HabitViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let fullDaysOfWeek = [String(localized: "Sun"), String(localized: "Mon"), String(localized: "Tue"), String(localized: "Wed"), String(localized: "Thu"), String(localized: "Fri"), String(localized: "Sat")]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("New Habit Title", text: $habitTitle)
                }
                
                Section {
                    DatePicker("Start Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    
                    HStack {
                        Text("Repeat ")
                        Spacer()
                        Text(repeatDaysText())
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        ForEach(0 ..< 7) { index in
                            Button(action: {
                                toggleDaySelection(index)
                            }) {
                                Text(daysOfWeek[index])
                                    .frame(width: 30, height: 30)
                                    .background(selectedDays.contains(index) ? Color.primaryRed : Color.clear)
                                    .foregroundColor(selectedDays.contains(index) ? .white : .primaryRed)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.primaryRed, lineWidth: selectedDays.contains(index) ? 0 : 1)
                                    )
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
                
                Section {
                    Toggle("Reminder", isOn: $reminderOn)
                        .onChange(of: reminderOn) { _ in
                            showTimePicker = false // Reset the time picker when the toggle is changed
                        }
                    
                    if reminderOn {
                        HStack {
                            Text("Time")
                            Spacer()
                            Text("\(selectedTime, formatter: timeFormatter)")
                                .foregroundColor(.primaryRed)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.15))
                                )
                                .onTapGesture {
                                    showTimePicker.toggle()
                                }
                        }
                        
                        if showTimePicker {
                            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                    }
                }
            }
            .navigationBarTitle("Add Habit", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                presentationMode.wrappedValue.dismiss()
            }),
            trailing: Button("Done", action: {
                saveHabit()
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .accentColor(.primaryRed)
        .onAppear {
            setInitialSelectedDay()
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private func repeatDaysText() -> String {
        let sortedDays = selectedDays.sorted()
        switch sortedDays {
        case [1, 2, 3, 4, 5]:
            return String(localized: "Every Weekday" )
        case [0, 6]:
            return String(localized: "Every Weekend")
        case [0, 1, 2, 3, 4, 5, 6]:
            return String(localized: "Everyday")
        default:
            let days = sortedDays.map { fullDaysOfWeek[$0] }
            return days.isEmpty ? String(localized: "None") : String(localized: "Every ")+days.joined(separator: ", ")
        }
    }
    
    private func toggleDaySelection(_ index: Int) {
        if selectedDays.contains(index) {
            if selectedDays.count > 1 {
                selectedDays.remove(index)
            }
        } else {
            selectedDays.insert(index)
        }
    }
    
    private func setInitialSelectedDay() {
        let currentDay = Calendar.current.component(.weekday, from: selectedDate) - 1
        selectedDays = [currentDay]
    }
    
    private func saveHabit() {
        let newHabit = HabitModel(title: habitTitle, body: "", days: selectedDays, startDate: selectedDate, emoji: emoji, time: selectedTime, isReminder: reminderOn)
        
        habitViewModel.add(item: newHabit)
        scheduleHabitNotifications(for: newHabit)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        SeedContainer(container: container)
        
        return AddHabitView()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}
