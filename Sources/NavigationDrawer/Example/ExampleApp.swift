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
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack(alignment: .topLeading) {
                HomeScreen()
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            .navigationDrawerModifier(geometry: geometry,
                                      uiColor: .systemTeal)
        }
    }
}

struct Example_Preview: PreviewProvider {
    
    static var previews: some View {
        ExampleApp()
    }
}
