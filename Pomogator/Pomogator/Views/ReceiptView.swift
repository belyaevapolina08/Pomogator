import SwiftUI

struct ReceiptView: View {
    @State private var scannedCode = ""
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📥 Приёмка товара")
                .font(.title)
            
            TextField("Отсканируйте штрихкод", text: $scannedCode)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
            
            Button("Принять товар") {
                if let product = MockDataService.products.first(where: { $0.sku == scannedCode }) {
                    MockDataService.updateProductQuantity(productId: product.id, newQuantity: product.quantity + 1)
                    message = "✅ Товар принят. Ячейка: A-12"
                } else {
                    message = "❌ Товар не найден"
                }
                scannedCode = ""
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Text(message)
                .foregroundColor(message.hasPrefix("✅") ? .green : .red)
            
            List(MockDataService.products) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.quantity) \(product.unit)")
                }
            }
        }
        .padding()
    }
}
