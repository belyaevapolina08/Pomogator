import SwiftUI

@main
struct PomogatorApp: App {
    @State private var isLoggedIn = false
    @State private var userRole = ""
    @State private var showRegistration = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                if userRole == "admin" {
                    AdminDashboardView()
                } else if userRole == "store" {
                    StorePanelView()
                } else {
                    KeeperView()
                }
            } else {
                if showRegistration {
                    RegistrationView(isLoggedIn: $isLoggedIn, userRole: $userRole, showRegistration: $showRegistration)
                } else {
                    LoginView(isLoggedIn: $isLoggedIn, userRole: $userRole, showRegistration: $showRegistration)
                }
            }
        }
        .windowResizability(.contentSize)
    }
}
