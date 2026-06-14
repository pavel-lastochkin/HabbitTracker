//
//  Habit.swift
//  HabbitTracker
//
//  Created by Pavel Lastochkin on 31.05.2026.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var isCompleted: Bool

    init(id: UUID = UUID(), name: String, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
}
