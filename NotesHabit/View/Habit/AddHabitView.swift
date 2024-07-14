import SwiftUI

struct AddHabitView: View {
    @Binding var showModal: Bool
    @State private var habitTitle: String = ""
    @State private var emoji: String = ""
    @State private var description: String = ""
    @State private var reminderOn: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var selectedTime: Date = Date()
    @State private var selectedDate: Date = Date()
    @State private var selectedDays: Set<Int> = []
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let fullDaysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Emoji", text: $emoji)
                    TextField("Habit Title", text: $habitTitle)
                    TextField("Description", text: $description)
                }
                
                Section {
                    HStack {
                        Text("Start Date")
                        Spacer()
                        
                        Text("\(selectedDate, formatter: dateFormatter)")
                            .foregroundColor(.primaryRed)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.gray.opacity(0.15))
                            )
                    }
                    .onTapGesture {
                        showDatePicker.toggle()
                    }
                    
                    if showDatePicker {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    
                    HStack {
                        Text("Repeat ")
                        Spacer()
                        Text(repeatDaysText())
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        ForEach(0..<7) { index in
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
                        .onChange(of: reminderOn) { value in
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
                // TODO: Tambahin function untuk SaveHabit disini
                saveHabit(title: self.habitTitle, body: self.description,emoji: self.emoji,startDate: self.selectedDate, repeatDay: self.selectedDays, reminder: self.reminderOn)
                
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .accentColor(.primaryRed)
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
            return "Every Weekday"
        case [0, 6]:
            return "Every Weekend"
        case [0, 1, 2, 3, 4, 5, 6]:
            return "Everyday"
        default:
            let days = sortedDays.map { fullDaysOfWeek[$0] }
            return days.isEmpty ? "None" : "Every " + days.joined(separator: ", ")
        }
    }
    
    private func toggleDaySelection(_ index: Int) {
        if selectedDays.contains(index) {
            selectedDays.remove(index)
        } else {
            selectedDays.insert(index)
        }
    }
    
    private func saveHabit(title: String,body: String,emoji: String, startDate: Date, repeatDay: Set<Int>, reminder: Bool ) {
        // Add your saving logic here
        print(title)
        print(startDate)
        print(repeatDay)
        print(reminder)
        let habit = HabitModel(title: title, body: body, days: repeatDay, startDate: startDate, emoji: emoji)
        context.insert(habit)
        self.showModal = false
        
        
        
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(showModal: Binding<Bool>.constant(true))
    }
}
