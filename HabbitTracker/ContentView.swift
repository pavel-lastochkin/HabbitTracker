//
//  ContentView.swift
//  HabbitTracker
//
//  Created by Pavel Lastochkin on 31.05.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var store = HabitStore()
    @State private var showingAddHabit = false
    @State private var newHabitName = ""

    var body: some View {
        NavigationStack {
            List(store.habits) { habit in
                HStack {
                    Text(habit.name)
                    Spacer()
                    Toggle("", isOn: completionBinding(for: habit))
                        .labelsHidden()
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        newHabitName = ""
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitSheet(
                    name: $newHabitName,
                    onAdd: {
                        store.addHabit(name: newHabitName)
                        showingAddHabit = false
                    },
                    onCancel: {
                        showingAddHabit = false
                    }
                )
            }
        }
    }

    private func completionBinding(for habit: Habit) -> Binding<Bool> {
        Binding(
            get: { store.habits.first(where: { $0.id == habit.id })?.isCompleted ?? false },
            set: { newValue in
                guard let index = store.habits.firstIndex(where: { $0.id == habit.id }) else { return }
                store.habits[index].isCompleted = newValue
            }
        )
    }
}

private struct AddHabitSheet: View {
    @Binding var name: String
    let onAdd: () -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit name", text: $name)
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: onAdd)
                        .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ContentView()
}
