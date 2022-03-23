//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Taylor on 10/25/21.
//

import SwiftUI

@main
// Make ScrumsView the app's root, need to conform to app protocol
// Body property returns a Scene that contains a view hierarchy
// using primary user interface for the app
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
