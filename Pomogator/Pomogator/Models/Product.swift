import Foundation

struct Product: Identifiable {
    let id: Int
    let sku: String
    let name: String
    var quantity: Int
    let minStock: Int
    let maxStock: Int
    let unit: String
    let expiryDate: String?
}
