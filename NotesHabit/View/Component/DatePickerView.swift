import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    var onDateChange: (Date) -> Void

    var body: some View {
        DatePicker(String(localized: "Select a date"), selection: $selectedDate, displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .padding()
            .accentColor(.primaryRed)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var selectedDate = Date()

    static var previews: some View {
        DatePickerView(selectedDate: $selectedDate) { _ in
        }
    }
}
