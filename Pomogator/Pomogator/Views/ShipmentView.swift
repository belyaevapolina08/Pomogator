import SwiftUI

struct ShipmentView: View {
    @State private var selectedOrder: Order? = nil
    @State private var showAlert = false
    @State private var step = 0
    
    var body: some View {
        VStack {
            Text("📦 Отгрузка товара")
                .font(.title)
                .padding()
            
            List(MockDataService.orders) { order in
                HStack {
                    VStack(alignment: .leading) {
                        Text(order.productName).font(.headline)
                        Text("Кол-во: \(order.quantity) шт.")
                        Text("Статус: \(order.status)")
                    }
                    Spacer()
                    Button("Собрать") {
                        selectedOrder = order
                        step = 0
                    }
                    .disabled(order.status != "new")
                }
            }
        }
        .sheet(item: $selectedOrder) { order in
            VStack(spacing: 20) {
                Text("Сборка заказа #\(order.id)").font(.title2)
                Text("Товар: \(order.productName)")
                Text("Количество: \(order.quantity) шт.")
                
                ForEach(MockDataService.route.indices, id: \.self) { i in
                    HStack {
                        Image(systemName: step > i ? "checkmark.circle.fill" : "circle")
                        Text(MockDataService.route[i])
                        if step == i { Button("Сканировать") { step += 1 } }
                    }
                }
                
                if step == MockDataService.route.count {
                    Button("Подтвердить отгрузку") {
                        showAlert = true
                        selectedOrder = nil
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            }
            .padding()
            .frame(width: 400, height: 350)
        }
        .alert("Отгрузка завершена", isPresented: $showAlert) {
            Button("OK") { }
        }
    }
}
