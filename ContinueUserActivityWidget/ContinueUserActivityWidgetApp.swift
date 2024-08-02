//
//  ContinueUserActivityWidgetApp.swift
//  ContinueUserActivityWidget
//
//  Created by Philippe Weidmann on 20.07.2024.
//

import NotificationCenter
import OSLog
import SwiftUI

public extension Notification.Name {
    static let favoriteEmoji = Notification.Name("favoriteEmoji")
}

public extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "Main"

    static let misc = Logger(subsystem: subsystem, category: "Misc")
}

@main
struct ContinueUserActivityWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity("ConfigurationAppIntent") { userActivity in
                    handleUserActivity(userActivity)
                }
                .onOpenURL { url in
                    guard let scheme = url.scheme,
                          scheme.contains("SampleWidget") else {
                        return
                    }

                    let favoriteEmoji = url.lastPathComponent
                    NotificationCenter.default.post(name: .favoriteEmoji, object: "From URL \(favoriteEmoji)")
                }
        }
    }

    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard let configuration: ConfigurationAppIntent = userActivity
            .widgetConfigurationIntent() else {
            Logger.misc.error("Couldn't cast activity \(userActivity.description)")
            return
        }
        let favoriteEmoji = configuration.favoriteEmoji
        NotificationCenter.default.post(name: .favoriteEmoji, object: "From UA \(favoriteEmoji)")
    }
}
