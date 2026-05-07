import SwiftUI

struct StorePanelView: View {
    @State private var selectedProduct = "Молоко 1л (арт. 4601234567890)"
    @State private var quantity = "1"
    @State private var orderItems: [(product: String, quantity: String)] = []
    
    let products = ["Молоко 1л (арт. 4601234567890)", "Хлеб чёрный (арт. 4601234567891)", "Масло сливочное (арт. 4601234567892)"]
    
    var totalItems: Int {
        orderItems.count
    }
    
    var totalQuantity: Int {
        orderItems.reduce(0) { $0 + (Int($1.quantity) ?? 0) }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🏪 МАГАЗИН «Солнечный»")
                .font(.title)
                .padding(.top)
            
            Text("Заказ товаров")
                .font(.title2)
            Text("Оформите заявку на пополнение ассортимента")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(alignment: .top, spacing: 30) {
                // Форма заказа
                VStack(alignment: .leading, spacing: 15) {
                    Text("Новая заявка").font(.headline)
                    
                    Picker("Товар", selection: $selectedProduct) {
                        ForEach(products, id: \.self) { Text($0) }
                    }
                    .frame(width: 250)
                    
                    HStack {
                        Text("Количество")
                        TextField("", text: $quantity)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 80)
                        Button("Добавить позицию") {
                            orderItems.append((selectedProduct, quantity))
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Итого позиций: \(totalItems)")
                        Spacer()
                        Text("Общее количество: \(totalQuantity) шт.")
                    }
                    
                    Button("Отправить заявку") {
                        orderItems.removeAll()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
                .padding()
                .frame(width: 350)
                .background(Color(.windowBackgroundColor))
                .cornerRadius(12)
                
                // История заказов
                VStack(alignment: .leading, spacing: 15) {
                    Text("Последние заказы").font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack { Text("№ 1236"); Spacer(); Text("В обработке").foregroundColor(.blue); Text("22.04") }
                        HStack { Text("№ 1230"); Spacer(); Text("Отгружен").foregroundColor(.green); Text("18.04") }
                        HStack { Text("№ 1222"); Spacer(); Text("Сборка").foregroundColor(.orange); Text("15.04") }
                    }
                    
                    Button("История заказов →") { }
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .padding()
                .frame(width: 250)
                .background(Color(.windowBackgroundColor))
                .cornerRadius(12)
            }
            
            Spacer()
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}
