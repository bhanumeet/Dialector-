import SwiftUI
import FirebaseCore

@main
struct DialectorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AuthView()
                .environmentObject(AppState())
        }
    }
}
