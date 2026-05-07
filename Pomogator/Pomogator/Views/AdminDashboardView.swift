import SwiftUI

struct AdminDashboardView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardHomeView(selectedTab: $selectedTab)
                .tabItem { Label("Главная", systemImage: "house.fill") }
                .tag(0)
            ProductsManagementView()
                .tabItem { Label("Товары", systemImage: "shippingbox.fill") }
                .tag(1)
            UsersManagementView()
                .tabItem { Label("Пользователи", systemImage: "person.3.fill") }
                .tag(2)
            CellsManagementView()
                .tabItem { Label("Ячейки", systemImage: "square.grid.2x2.fill") }
                .tag(3)
            AdminOrdersView()
                .tabItem { Label("Заказы", systemImage: "list.bullet.rectangle") }
                .tag(4)
            BatchesView()
                .tabItem { Label("Партии", systemImage: "doc.plaintext") }
                .tag(5)
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

// MARK: - Главная страница с KPI
struct DashboardHomeView: View {
    @Binding var selectedTab: Int
    
    let stats = [
        ("📦", "1 245", "товаров", "↑ 5%", Color.green),
        ("📍", "48", "ячеек", "↓ 2%", Color.red),
        ("📋", "23", "заказа", "↑ 12%", Color.green),
        ("👥", "12", "активных", "→ 0%", Color.gray)
    ]
    
    let systemItems = ["Пользователи (12)", "Резервное копирование", "Системные логи", "Настройки"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Добро пожаловать, Администратор")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("📅 30.04.2026")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(stats, id: \.0) { stat in
                        VStack {
                            Text(stat.0).font(.largeTitle)
                            Text(stat.1).font(.title).bold()
                            Text(stat.2).font(.caption).foregroundColor(.gray)
                            Text(stat.3).font(.caption2).foregroundColor(stat.4)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.windowBackgroundColor))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                HStack(alignment: .top, spacing: 20) {
                    // Последние заказы
                    VStack(alignment: .leading) {
                        Text("Последние заказы").font(.headline).padding(.bottom, 5)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack { Text("№1234 - Магазин 5"); Spacer(); Text("Отгружен").foregroundColor(.green) }
                            HStack { Text("№1235 - Магазин 2"); Spacer(); Text("Сборка").foregroundColor(.orange) }
                            HStack { Text("№1236 - Магазин 7"); Spacer(); Text("Новый").foregroundColor(.blue) }
                        }
                        
                        Button("Показать все →") {
                            selectedTab = 4
                        }
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.windowBackgroundColor))
                    .cornerRadius(12)
                    
                    // Управление системой
                    VStack(alignment: .leading) {
                        Text("Управление системой").font(.headline).padding(.bottom, 5)
                        ForEach(systemItems, id: \.self) { item in
                            Text(item).padding(.vertical, 2)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.windowBackgroundColor))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // График активности
                VStack(alignment: .leading) {
                    Text("График активности").font(.headline).padding(.bottom, 5)
                    HStack(alignment: .bottom, spacing: 10) {
                        ForEach(["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"], id: \.self) { day in
                            VStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.green)
                                    .frame(height: CGFloat.random(in: 20...60))
                                Text(day).font(.caption2)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
                .background(Color(.windowBackgroundColor))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Управление товарами
struct ProductsManagementView: View {
    @State private var products = MockDataService.products
    @State private var searchText = ""
    @State private var showingAddProduct = false
    
    var filteredProducts: [Product] {
        if searchText.isEmpty { return products }
        return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.sku.contains(searchText) }
    }
    
    var body: some View {
        VStack {
            Text("Управление товарами")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Поиск по артикулу или наименованию...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                Spacer()
                Button("+ Добавить товар") {
                    showingAddProduct = true
                }
            }
            .padding(.horizontal)
            
            List {
                HStack {
                    Text("ID").frame(width: 40, alignment: .leading)
                    Text("Артикул (SKU)").frame(width: 130, alignment: .leading)
                    Text("Наименование").frame(width: 150, alignment: .leading)
                    Text("Ед. изм.").frame(width: 70, alignment: .leading)
                    Text("Остаток").frame(width: 60, alignment: .trailing)
                    Text("Мин.").frame(width: 50, alignment: .trailing)
                    Text("Макс.").frame(width: 50, alignment: .trailing)
                    Text("Действия").frame(width: 80, alignment: .center)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                ForEach(filteredProducts) { product in
                    HStack {
                        Text("\(product.id)").frame(width: 40, alignment: .leading)
                        Text(product.sku).frame(width: 130, alignment: .leading).font(.caption)
                        Text(product.name).frame(width: 150, alignment: .leading)
                        Text(product.unit).frame(width: 70, alignment: .leading)
                        Text("\(product.quantity)").frame(width: 60, alignment: .trailing)
                        Text("\(product.minStock)").frame(width: 50, alignment: .trailing)
                        Text("\(product.maxStock)").frame(width: 50, alignment: .trailing)
                        HStack {
                            Button("✏️") { }
                            Button("🗑️") { }
                        }
                        .frame(width: 80, alignment: .center)
                    }
                }
            }
            
            HStack {
                Text("Показано \(filteredProducts.count) из \(MockDataService.products.count) товаров")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingAddProduct) {
            AddProductView(products: $products)
        }
    }
}

struct AddProductView: View {
    @Binding var products: [Product]
    @Environment(\.dismiss) var dismiss
    @State private var sku = ""
    @State private var name = ""
    @State private var unit = "шт"
    @State private var minStock = "10"
    @State private var maxStock = "100"
    
    let units = ["шт", "кг", "л"]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Добавить товар").font(.title2)
            TextField("Артикул (SKU)", text: $sku).textFieldStyle(.roundedBorder)
            TextField("Наименование", text: $name).textFieldStyle(.roundedBorder)
            Picker("Ед. изм.", selection: $unit) {
                ForEach(units, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            TextField("Мин. остаток", text: $minStock).textFieldStyle(.roundedBorder)
            TextField("Макс. остаток", text: $maxStock).textFieldStyle(.roundedBorder)
            HStack {
                Button("Отмена") { dismiss() }
                Button("Сохранить") {
                    let newProduct = Product(id: (products.last?.id ?? 0) + 1, sku: sku, name: name, quantity: 0, minStock: Int(minStock) ?? 10, maxStock: Int(maxStock) ?? 100, unit: unit, expiryDate: nil)
                    products.append(newProduct)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding()
        .frame(width: 350, height: 400)
    }
}

// MARK: - Управление пользователями
struct UsersManagementView: View {
    @State private var users = MockDataService.users
    @State private var searchText = ""
    @State private var showingAddUser = false
    
    var filteredUsers: [User] {
        if searchText.isEmpty { return users }
        return users.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) || $0.login.contains(searchText) }
    }
    
    func russianRole(_ role: String) -> String {
        switch role {
        case "keeper": return "Кладовщик"
        case "admin": return "Администратор"
        case "store": return "Магазин"
        case "manager": return "Менеджер"
        case "head": return "Руководитель"
        default: return role
        }
    }
    
    var body: some View {
        VStack {
            Text("Управление пользователями")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Поиск по фамилии, имени или логину...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                Spacer()
                Button("+ Добавить пользователя") {
                    showingAddUser = true
                }
            }
            .padding(.horizontal)
            
            List {
                HStack {
                    Text("ID").frame(width: 40, alignment: .leading)
                    Text("ФИО").frame(width: 200, alignment: .leading)
                    Text("Логин").frame(width: 100, alignment: .leading)
                    Text("Должность").frame(width: 130, alignment: .leading)
                    Text("Статус").frame(width: 80, alignment: .leading)
                    Text("Дата рег.").frame(width: 90, alignment: .leading)
                    Text("Действия").frame(width: 80, alignment: .center)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                ForEach(filteredUsers) { user in
                    HStack {
                        Text("\(user.id)").frame(width: 40, alignment: .leading)
                        Text(user.fullName).frame(width: 200, alignment: .leading)
                        Text(user.login).frame(width: 100, alignment: .leading)
                        Text(russianRole(user.role)).frame(width: 130, alignment: .leading)
                        Text("Активен").frame(width: 80, alignment: .leading).foregroundColor(.green)
                        Text("01.04.2026").frame(width: 90, alignment: .leading)
                        HStack {
                            Button("✏️") { }
                            Button("🗑️") { }
                        }
                        .frame(width: 80, alignment: .center)
                    }
                }
            }
            
            HStack {
                Text("Показано \(filteredUsers.count) из \(MockDataService.users.count) пользователей")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingAddUser) {
            AddUserView(users: $users)
        }
    }
}

struct AddUserView: View {
    @Binding var users: [User]
    @Environment(\.dismiss) var dismiss
    @State private var fullName = ""
    @State private var login = ""
    @State private var role = "Кладовщик"
    
    let roles = ["Кладовщик", "Менеджер по закупкам", "Руководитель склада", "Администратор", "Магазин"]
    
    func englishRole(_ russian: String) -> String {
        switch russian {
        case "Кладовщик": return "keeper"
        case "Менеджер по закупкам": return "manager"
        case "Руководитель склада": return "head"
        case "Администратор": return "admin"
        case "Магазин": return "store"
        default: return "keeper"
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Добавить пользователя").font(.title2)
            TextField("ФИО", text: $fullName).textFieldStyle(.roundedBorder)
            TextField("Логин", text: $login).textFieldStyle(.roundedBorder)
            Picker("Должность", selection: $role) {
                ForEach(roles, id: \.self) { Text($0) }
            }
            HStack {
                Button("Отмена") { dismiss() }
                Button("Сохранить") {
                    let newUser = User(id: (users.last?.id ?? 0) + 1, login: login, password: "123", role: englishRole(role), fullName: fullName)
                    users.append(newUser)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding()
        .frame(width: 350, height: 350)
    }
}

// MARK: - Управление ячейками
struct CellsManagementView: View {
    let cells = MockDataService.cells
    
    var body: some View {
        VStack {
            Text("Управление ячейками")
                .font(.title)
                .padding()
            
            Text("Схема склада")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 10) {
                ForEach(cells, id: \.self) { cell in
                    Text(cell)
                        .frame(width: 60, height: 40)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green))
                }
            }
            .padding()
            
            Button("+ Добавить ячейку") { }
                .buttonStyle(.borderedProminent)
                .tint(.green)
        }
    }
}

// MARK: - Управление заказами (админ)
struct AdminOrdersView: View {
    @State private var orders = MockDataService.orders
    @State private var searchText = ""
    @State private var selectedStatus = "Все"
    
    let statuses = ["Все", "new", "processing", "shipped"]
    
    var filteredOrders: [Order] {
        var result = orders
        if !searchText.isEmpty {
            result = result.filter { $0.productName.localizedCaseInsensitiveContains(searchText) }
        }
        if selectedStatus != "Все" {
            result = result.filter { $0.status == selectedStatus }
        }
        return result
    }
    
    func statusColor(_ status: String) -> Color {
        switch status {
        case "new": return .blue
        case "processing": return .orange
        case "shipped": return .green
        default: return .gray
        }
    }
    
    var body: some View {
        VStack {
            Text("Управление заказами")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Поиск по товару...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                
                Picker("Статус", selection: $selectedStatus) {
                    ForEach(statuses, id: \.self) { status in
                        Text(status == "Все" ? "Все" : status).tag(status)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 150)
                
                Spacer()
                
                Button("Обновить") {
                    orders = MockDataService.orders
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            
            List {
                HStack {
                    Text("ID").frame(width: 50, alignment: .leading)
                    Text("Товар").frame(width: 180, alignment: .leading)
                    Text("Кол-во").frame(width: 60, alignment: .trailing)
                    Text("Статус").frame(width: 100, alignment: .leading)
                    Text("Дата").frame(width: 100, alignment: .leading)
                    Text("Действия").frame(width: 120, alignment: .center)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                ForEach(filteredOrders) { order in
                    HStack {
                        Text("#\(order.id)").frame(width: 50, alignment: .leading)
                        Text(order.productName).frame(width: 180, alignment: .leading)
                        Text("\(order.quantity) шт.").frame(width: 60, alignment: .trailing)
                        Text(order.status)
                            .frame(width: 100, alignment: .leading)
                            .foregroundColor(statusColor(order.status))
                        Text("28.04.2026").frame(width: 100, alignment: .leading)
                        HStack(spacing: 15) {
                            Button("✏️") { }
                            Button("🗑️") { }
                        }
                        .frame(width: 120, alignment: .center)
                    }
                }
            }
            
            HStack {
                Text("Показано \(filteredOrders.count) из \(MockDataService.orders.count) заказов")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}

// MARK: - Управление партиями
struct BatchesView: View {
    @State private var batches = MockDataService.batches
    @State private var searchText = ""
    
    var filteredBatches: [Batch] {
        if searchText.isEmpty { return batches }
        return batches.filter { $0.productName.localizedCaseInsensitiveContains(searchText) }
    }
    
    func isExpired(_ date: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let expiryDate = formatter.date(from: date) else { return false }
        return expiryDate < Date()
    }
    
    var body: some View {
        VStack {
            Text("📦 Управление партиями")
                .font(.title)
                .padding()
            
            TextField("Поиск по товару...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .padding(.bottom)
            
            List {
                HStack {
                    Text("ID").frame(width: 40, alignment: .leading)
                    Text("Товар").frame(width: 120, alignment: .leading)
                    Text("Кол-во").frame(width: 60, alignment: .trailing)
                    Text("Дата пр-ва").frame(width: 90, alignment: .leading)
                    Text("Срок годн.").frame(width: 90, alignment: .leading)
                    Text("Ячейка").frame(width: 70, alignment: .leading)
                    Text("Статус").frame(width: 80, alignment: .leading)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                ForEach(filteredBatches) { batch in
                    HStack {
                        Text("\(batch.id)").frame(width: 40, alignment: .leading)
                        Text(batch.productName).frame(width: 120, alignment: .leading)
                        Text("\(batch.quantity)").frame(width: 60, alignment: .trailing)
                        Text(batch.manufactureDate).frame(width: 90, alignment: .leading)
                        Text(batch.expiryDate).frame(width: 90, alignment: .leading)
                        Text(batch.cell).frame(width: 70, alignment: .leading)
                        Text(isExpired(batch.expiryDate) ? "Просрочена" : "Действует")
                            .frame(width: 80, alignment: .leading)
                            .foregroundColor(isExpired(batch.expiryDate) ? .red : .green)
                    }
                }
            }
            
            HStack {
                Text("Показано \(filteredBatches.count) из \(MockDataService.batches.count) партий")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(minWidth: 650, minHeight: 500)
    }
}
