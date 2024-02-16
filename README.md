### Contents

Package provides two simple things to create a navigation drawer with a swipe gesture
- modifier struct `NavigationDrawerModifier`
- extension function `navigationDrawerModifier()`

### Usage

As seen in the `ExampleApp`, the only way to create a navigation drawer with a swipe gesture is
by using the `navigationDrawerModifier` extension function. The view onto which this
modifier is applied should have a `frame` because the `DragGesture` for swipe uses
this frame's bounds.

    GeometryReader() { geometry in
        ZStack(alignment: .topLeading) {
            HomeScreen()
        }
        .frame(width: geometry.size.width,
               height: geometry.size.height)
        .navigationDrawerModifier(geometry: geometry,
                                  scrimColor: UIColor.black,
                                  drawerColor: UIColor.systemTeal,
                                  drawerContent: drawerContent() as! AnyView)
    }

### Platforms

- macOS v13 and above
- iOS v16 and above

### Example

<img src="./readme_img/example.gif" width="500" alt="example" />