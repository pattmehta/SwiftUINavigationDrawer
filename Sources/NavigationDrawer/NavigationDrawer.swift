import SwiftUI

struct NavigationDrawerModifier: ViewModifier {
    
    @State private var animate: Bool = false
    let geometry: GeometryProxy
    let uiColor: UIColor
    let widthRatio = NavigationDrawerConstants.widthRatio
    let zIndex = NavigationDrawerConstants.zIndex
    let dragMinDistance = NavigationDrawerConstants.dragMinDistance
    
    init(geometry: GeometryProxy, uiColor: UIColor) {
        self.geometry = geometry
        self.uiColor = uiColor
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            Color(uiColor)
                .frame(width: geometry.size.width * widthRatio, height: geometry.size.height)
                .offset(x: animate ? 0 : -geometry.size.width)
                .animation(.spring(), value: animate)
                .zIndex(zIndex)
                .disabled(true)
            content
                .gesture(
                    DragGesture(minimumDistance: dragMinDistance, coordinateSpace: .global)
                    .onEnded { value in
                        let horizontalAmount = value.translation.width
                        let verticalAmount = value.translation.height
                        guard abs(horizontalAmount) > abs(verticalAmount) else {
                            return
                        }
                        if horizontalAmount > 0 && !animate {
                            animate = true
                        }
                        if horizontalAmount <= 0 && animate {
                            animate = false
                        }
                })
        }
    }
}

extension View {
    
    func navigationDrawerModifier(geometry: GeometryProxy, uiColor: UIColor) -> some View {
        ModifiedContent(
            content: self,
            modifier: NavigationDrawerModifier(geometry: geometry, uiColor: uiColor)
        )
    }
}
