import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.green
            Text("HomeScreen")
        }
    }
}

struct ExampleApp: View {
    
    @State private var navigationDrawerState: NavigationDrawerState = .closed
    @State private var navigationDrawerDisabledState: Bool = false
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack(alignment: .topLeading) {
                HomeScreen()
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            .navigationDrawerModifier(geometry: geometry,
                                      scrimColor: UIColor.black,
                                      drawerColor: UIColor.systemTeal,
                                      drawerContent: drawerContent() as! AnyView,
                                      navigationDrawerState: $navigationDrawerState,
                                      navigationDrawerDisabledState: $navigationDrawerDisabledState)
        }
    }
}

extension ExampleApp {
    
    @ViewBuilder
    func drawerContent() -> some View {
        VStack(alignment: .leading) {
            Text("drawer content").font(.system(size: 8))
            Button("Option") {
                print("drawer option clicked")
                navigationDrawerState = .closed
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(width: 250, alignment: .topLeading)
        .overlay(Rectangle().stroke(lineWidth: 1))
        .offset(y: 20)
    }
}

struct Example_Preview: PreviewProvider {
    
    static var previews: some View {
        ExampleApp()
    }
}
