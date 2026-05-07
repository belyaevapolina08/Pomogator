import SwiftUI

struct KeeperView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ReceiptView()
                .tabItem { Label("Приёмка", systemImage: "arrow.down.doc") }
                .tag(0)
            ShipmentView()
                .tabItem { Label("Отгрузка", systemImage: "arrow.up.doc") }
                .tag(1)
            InventoryView()
                .tabItem { Label("Инвентаризация", systemImage: "checklist") }
                .tag(2)
        }
        .frame(minWidth: 600, minHeight: 500)
    }
}
