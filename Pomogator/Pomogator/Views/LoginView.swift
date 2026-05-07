import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userRole: String
    @Binding var showRegistration: Bool
    @State private var login = ""
    @State private var password = ""
    @State private var showError = false
    @State private var rememberMe = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📦 ПОМОГАТОР")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("Вход в систему")
                .font(.title2)
            
            TextField("Логин", text: $login)
                .textFieldStyle(.roundedBorder)
                .frame(width: 250)
            
            SecureField("Пароль", text: $password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 250)
            
            HStack {
                Toggle("Запомнить меня", isOn: $rememberMe)
                    .toggleStyle(.checkbox)
                    .frame(width: 150)
                Spacer()
                Button("Забыли пароль?") { }
                    .buttonStyle(.plain)
                    .foregroundColor(.green)
            }
            .frame(width: 250)
            
            Button("Войти") {
                if login == "keeper" && password == "123" {
                    userRole = "keeper"
                    isLoggedIn = true
                } else if login == "admin" && password == "admin" {
                    userRole = "admin"
                    isLoggedIn = true
                } else if login == "store" && password == "123" {
                    userRole = "store"
                    isLoggedIn = true
                } else if login == "manager" && password == "123" {
                    userRole = "manager"
                    isLoggedIn = true
                } else if login == "head" && password == "123" {
                    userRole = "head"
                    isLoggedIn = true
                } else {
                    showError = true
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Text("или")
                .foregroundColor(.gray)
            
            Button("Регистрация") {
                showRegistration = true
            }
            .buttonStyle(.bordered)
            
            if showError {
                Text("Неверный логин или пароль")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Text("Версия 2.0 для склада «Помогатор»")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.top, 20)
        }
        .padding()
        .frame(width: 400, height: 550)
    }
}
