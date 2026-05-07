import SwiftUI

struct RegistrationView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userRole: String
    @Binding var showRegistration: Bool
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var middleName = ""
    @State private var login = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedRole = "Кладовщик"
    @State private var agreeTerms = false
    @State private var showSuccess = false
    
    let roles = ["Кладовщик", "Менеджер по закупкам", "Руководитель склада", "Администратор"]
    
    var body: some View {
        VStack(spacing: 12) {
            Text("📦 ПОМОГАТОР")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("Регистрация")
                .font(.title2)
            
            Text("Создайте новый аккаунт")
                .font(.caption)
                .foregroundColor(.gray)
            
            Group {
                TextField("Фамилия", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                TextField("Имя", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                TextField("Отчество (необязательно)", text: $middleName)
                    .textFieldStyle(.roundedBorder)
                TextField("Логин", text: $login)
                    .textFieldStyle(.roundedBorder)
                TextField("Электронная почта", text: $email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Пароль", text: $password)
                    .textFieldStyle(.roundedBorder)
                SecureField("Подтверждение пароля", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
            }
            .frame(width: 300)
            
            Picker("Роль", selection: $selectedRole) {
                ForEach(roles, id: \.self) { role in
                    Text(role).tag(role)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 300)
            
            Toggle("Я соглашаюсь с условиями использования", isOn: $agreeTerms)
                .toggleStyle(.checkbox)
                .font(.caption)
                .frame(width: 300)
            
            Button("Зарегистрироваться") {
                if password == confirmPassword && agreeTerms {
                    showSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showRegistration = false
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .disabled(!agreeTerms)
            
            Button("Уже есть аккаунт? Войти") {
                showRegistration = false
            }
            .buttonStyle(.plain)
            .foregroundColor(.green)
            
            if showSuccess {
                Text("✅ Регистрация успешна!")
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
        .padding()
        .frame(width: 450, height: 650)
    }
}
