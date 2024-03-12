import SwiftUI

public enum NavigationDrawerState {
    case opened
    case closed
}

struct NavigationDrawerModifier: ViewModifier {
    
    @Binding private var navigationDrawerState: NavigationDrawerState
    @Binding private var navigationDrawerDisabledState: Bool
    let geometry: GeometryProxy
    let scrimColor: UIColor
    let drawerColor: UIColor
    let drawerContent: AnyView
    let scrimOpacity = NavigationDrawerConstants.scrimOpacity
    let widthRatio = NavigationDrawerConstants.widthRatio
    let zIndex = NavigationDrawerConstants.zIndex
    let dragMinDistance = NavigationDrawerConstants.dragMinDistance
    
    init(geometry: GeometryProxy, scrimColor: UIColor, drawerColor: UIColor,
         drawerContent: AnyView,
         navigationDrawerState: Binding<NavigationDrawerState>, navigationDrawerDisabledState: Binding<Bool>) {
        self.geometry = geometry
        self.scrimColor = scrimColor
        self.drawerColor = drawerColor
        self.drawerContent = drawerContent
        self._navigationDrawerState = navigationDrawerState
        self._navigationDrawerDisabledState = navigationDrawerDisabledState
    }
    
    var height: CGFloat {
        geometry.size.height
    }
    
    var isDrawerOpened: Bool {
        navigationDrawerState == .opened
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            Group {
                Color(scrimColor)
                    .opacity(isDrawerOpened ? scrimOpacity : 0.0)
                    .animation(.spring(), value: isDrawerOpened)
                    .frame(width: geometry.size.width, height: height)
                    .allowsHitTesting(false)
                Group {
                    Color(drawerColor)
                        .frame(width: geometry.size.width * widthRatio, height: height)
                        .allowsHitTesting(false)
                    drawerContent
                }
                .offset(x: isDrawerOpened ? 0 : -geometry.size.width)
                .animation(.spring(), value: isDrawerOpened)
            }.zIndex(zIndex)
            content
                .gesture(
                    DragGesture(minimumDistance: dragMinDistance, coordinateSpace: .global)
                    .onEnded { value in
                        if navigationDrawerDisabledState {
                            return
                        }
                        let horizontalAmount = value.translation.width
                        let verticalAmount = value.translation.height
                        guard abs(horizontalAmount) > abs(verticalAmount) else {
                            return
                        }
                        if horizontalAmount > 0 && !isDrawerOpened {
                            navigationDrawerState = .opened
                        }
                        if horizontalAmount <= 0 && isDrawerOpened {
                            navigationDrawerState = .closed
                        }
                })
        }
    }
}

extension View {
    
    public func navigationDrawerModifier(
        geometry: GeometryProxy, scrimColor: UIColor, drawerColor: UIColor,
        drawerContent: AnyView, navigationDrawerState: Binding<NavigationDrawerState>, navigationDrawerDisabledState: Binding<Bool>) -> some View {
        ModifiedContent(
            content: self,
            modifier: NavigationDrawerModifier(geometry: geometry, scrimColor: scrimColor, drawerColor: drawerColor,
                                               drawerContent: drawerContent,
                                               navigationDrawerState: navigationDrawerState, navigationDrawerDisabledState: navigationDrawerDisabledState)
        )
    }
}
