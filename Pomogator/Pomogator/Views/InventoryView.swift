import SwiftUI

struct InventoryView: View {
    @State private var actualQuantity = ""
    @State private var result = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📋 Инвентаризация")
                .font(.title)
            
            Text("Ожидаемое количество: 45 шт.")
            
            TextField("Фактическое количество", text: $actualQuantity)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            
            Button("Сравнить") {
                if let actual = Int(actualQuantity) {
                    let diff = actual - 45
                    result = diff == 0 ? "✅ Расхождений нет" : "⚠️ Расхождение: \(diff) шт. Акт сформирован"
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Text(result)
        }
        .padding()
        .frame(width: 400, height: 300)
    }
}
