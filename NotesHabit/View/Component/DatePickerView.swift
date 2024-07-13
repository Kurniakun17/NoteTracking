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
            .accentColor(.primaryRed)
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
