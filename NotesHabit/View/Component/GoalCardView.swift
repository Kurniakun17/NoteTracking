import SwiftUI
import SwiftData

struct GoalCard: View {
    let goal: HabitModel
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 80, height: 80)
                .overlay(
                    Text(goal.emoji)
                        .font(.system(size: 40))
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(goal.folder?.title ?? String(localized: "No Folder"))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(goal.title)
                    .font(.headline)
                
                HStack {
                    HStack {
                        Image(systemName: "flame")
                        Text("\(goal.streak)")
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                        Text(timeString(from: goal.time))
                    }
                }
                .foregroundColor(.gray)
                .font(.system(size: 14))
            }
            
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        
    }
    
    func timeString(from date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        if let date = date {
            return formatter.string(from: date)
        } else {
            return String(localized: "Add Reminder")
        }
    }
}


struct ContentView3: View {
    let goalsContent: [HabitModel] = [
        HabitModel(title: "Morning Routines", body: "Personal", days: [2, 4, 6], startDate: Date(), emoji: "🌅", notes: [], streak: 5, lastLog: Date()),
        HabitModel(title: "SwiftUI Learn", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "📚", notes: [], time: Date(), streak: 10, lastLog: Date()),
        HabitModel(title: "Learn Figma", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "🎨", notes: [], time: Date(), streak: 10, lastLog: Date())
    ]
    
    var body: some View {
        ScrollView {
            ForEach(goalsContent) { goal in
                GoalCard(goal: goal)
                    .padding(.horizontal)
                    .padding(.top, 4)
            }
        }
    }
}


#Preview {
    do
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return ContentView3()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}

