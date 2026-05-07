import Foundation

struct Order: Identifiable {
    let id: Int
    let productName: String
    let quantity: Int
    let status: String
    let date: String = "28.04.2026"  // дата для отображения
}
