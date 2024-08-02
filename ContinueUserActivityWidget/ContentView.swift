//
//  ContentView.swift
//  ContinueUserActivityWidget
//
//  Created by Philippe Weidmann on 20.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteEmoji = ""

    var body: some View {
        VStack {
            Text("Favorite emoji is:")
            Text(favoriteEmoji)
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: .favoriteEmoji).receive(on: DispatchQueue.main)) { notification in
            guard let favoriteEmoji = notification.object as? String else { return }
            self.favoriteEmoji = favoriteEmoji
        }
    }
}

#Preview {
    ContentView()
}
