//
//  ContentView.swift
//  HabbitTracker
//
//  Created by Pavel Lastochkin on 31.05.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Habit Tracker")
                .font(.largeTitle)

            Text("My Habits")
                .font(.headline)

            Text("🏋️ Gym")

            Text("📚 Read")

            Text("🎾 Tennis")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
