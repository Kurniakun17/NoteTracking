import SwiftUI
import SwiftData

// MARK: ini cuman untuk tes deleted habit

struct DeletedHabitView: View {
    @Binding var goalsContent: [HabitModel]
    
    var body: some View {
        VStack {
            Text("Deleted Goals")
                .font(.system(size: 40, weight: .bold))
                .padding()
            
            if deletedGoals.isEmpty {
                Text("No deleted goals")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(deletedGoals) { goal in
                        GoalCard(goal: goal)
                            .padding(.horizontal, -10)
                    }
                }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.visible)
            }
        }
        .background(Color(.systemBackground))
    }
    
    var deletedGoals: [HabitModel] {
        // Show Habit with deleteAt
        return goalsContent.filter { $0.deleteAt != nil }
    }
}

#Preview {
    do
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return DeletedHabitView(goalsContent: .constant([
            HabitModel(title: "Sample Goal 1", body: "Body 1", days: [1], startDate: Date(), emoji: "😊", notes: [], deleteAt: Date()),
            HabitModel(title: "Sample Goal 2", body: "Body 2", days: [2], startDate: Date(), emoji: "🚀", notes: [], deleteAt: Date())
        ]))
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}


