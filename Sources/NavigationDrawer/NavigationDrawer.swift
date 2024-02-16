import SwiftUI

struct NavigationDrawerModifier: ViewModifier {
    
    @State private var animate: Bool = false
    let geometry: GeometryProxy
    let scrimColor: UIColor
    let drawerColor: UIColor
    let drawerContent: AnyView
    let scrimOpacity = NavigationDrawerConstants.scrimOpacity
    let widthRatio = NavigationDrawerConstants.widthRatio
    let zIndex = NavigationDrawerConstants.zIndex
    let dragMinDistance = NavigationDrawerConstants.dragMinDistance
    
    init(geometry: GeometryProxy, scrimColor: UIColor, drawerColor: UIColor, drawerContent: AnyView) {
        self.geometry = geometry
        self.scrimColor = scrimColor
        self.drawerColor = drawerColor
        self.drawerContent = drawerContent
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            Group {
                Color(scrimColor)
                    .opacity(animate ? scrimOpacity : 0.0)
                    .animation(.spring(), value: animate)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .allowsHitTesting(false)
                Group {
                    Color(drawerColor)
                        .frame(width: geometry.size.width * widthRatio, height: geometry.size.height)
                        .allowsHitTesting(false)
                    drawerContent
                }
                .offset(x: animate ? 0 : -geometry.size.width)
                .animation(.spring(), value: animate)
            }.zIndex(zIndex)
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
    
    public func navigationDrawerModifier(geometry: GeometryProxy, scrimColor: UIColor, drawerColor: UIColor, drawerContent: AnyView) -> some View {
        ModifiedContent(
            content: self,
            modifier: NavigationDrawerModifier(geometry: geometry, scrimColor: scrimColor, drawerColor: drawerColor, drawerContent: drawerContent)
        )
    }
}
