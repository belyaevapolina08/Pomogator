import Foundation

struct Batch: Identifiable {
    let id: Int
    let productId: Int
    let productName: String
    let quantity: Int
    let manufactureDate: String
    let expiryDate: String
    let cell: String
}
