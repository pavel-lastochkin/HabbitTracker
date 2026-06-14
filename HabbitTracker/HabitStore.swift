//
//  HabitStore.swift
//  HabbitTracker
//
//  Created by Pavel Lastochkin on 31.05.2026.
//

import Foundation
import Observation

@Observable
final class HabitStore {
    private static let storageKey = "habits"

    var habits: [Habit] = [] {
        didSet { save() }
    }

    init() {
        load()
    }

    func addHabit(name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        habits.append(Habit(name: trimmed))
    }

    func toggleCompletion(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].isCompleted.toggle()
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decoded
        } else {
            habits = [
                Habit(name: "Gym"),
                Habit(name: "Read"),
                Habit(name: "Tennis"),
            ]
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(habits) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }
}
