import Foundation

class MockDataService {
    
    // MARK: - Товары
    static var products = [
        Product(id: 1, sku: "4601234567890", name: "Молоко 1л", quantity: 45, minStock: 10, maxStock: 100, unit: "шт", expiryDate: "2026-05-20"),
        Product(id: 2, sku: "4601234567891", name: "Хлеб чёрный", quantity: 12, minStock: 10, maxStock: 50, unit: "шт", expiryDate: "2026-05-05"),
        Product(id: 3, sku: "4601234567892", name: "Масло сливочное", quantity: 8, minStock: 10, maxStock: 30, unit: "шт", expiryDate: "2026-05-25")
    ]
    
    // MARK: - Заказы (для отгрузки кладовщиком и для админки)
    static var orders = [
        Order(id: 101, productName: "Молоко 1л", quantity: 5, status: "new"),
        Order(id: 102, productName: "Хлеб чёрный", quantity: 10, status: "new"),
        Order(id: 103, productName: "Масло сливочное", quantity: 2, status: "processing"),
        Order(id: 104, productName: "Сыр Российский", quantity: 3, status: "shipped"),
        Order(id: 105, productName: "Колбаса Докторская", quantity: 1, status: "new")
    ]
    
    // MARK: - Пользователи (для админки)
    static var users = [
        User(id: 1, login: "keeper", password: "123", role: "keeper", fullName: "Иванов Иван Иванович"),
        User(id: 2, login: "admin", password: "admin", role: "admin", fullName: "Козлова Анна Дмитриевна"),
        User(id: 3, login: "store", password: "123", role: "store", fullName: "Магазин Солнечный"),
        User(id: 4, login: "manager", password: "123", role: "manager", fullName: "Петрова Мария Сергеевна"),
        User(id: 5, login: "head", password: "123", role: "head", fullName: "Сидоров Алексей Владимирович")
    ]
    
    // MARK: - Партии товаров
    static var batches = [
        Batch(id: 1, productId: 1, productName: "Молоко 1л", quantity: 20, manufactureDate: "2026-04-20", expiryDate: "2026-05-20", cell: "A-12"),
        Batch(id: 2, productId: 1, productName: "Молоко 1л", quantity: 25, manufactureDate: "2026-04-25", expiryDate: "2026-05-25", cell: "A-13"),
        Batch(id: 3, productId: 2, productName: "Хлеб чёрный", quantity: 12, manufactureDate: "2026-04-28", expiryDate: "2026-05-05", cell: "B-03"),
        Batch(id: 4, productId: 3, productName: "Масло сливочное", quantity: 8, manufactureDate: "2026-04-15", expiryDate: "2026-05-15", cell: "C-07")
    ]
    
    // MARK: - Ячейки склада
    static let cells = ["A-01", "A-02", "A-03", "B-01", "B-02", "C-01", "C-02", "C-03"]
    
    // MARK: - Маршрут сборки (для отгрузки)
    static let route = ["Ячейка A-12", "Ячейка B-03", "Ячейка C-07"]
    
    // MARK: - Методы
    static func updateProductQuantity(productId: Int, newQuantity: Int) {
        if let index = products.firstIndex(where: { $0.id == productId }) {
            products[index].quantity = newQuantity
        }
    }
    
    static func addProduct(_ product: Product) {
        products.append(product)
    }
    
    static func deleteProduct(at index: Int) {
        products.remove(at: index)
    }
    
    static func addUser(_ user: User) {
        users.append(user)
    }
    
    static func deleteUser(at index: Int) {
        users.remove(at: index)
    }
}
