### Modifier

Package provides two simple things to create a navigation drawer with a swipe gesture
- modifier struct `NavigationDrawerModifier`
- extension function `navigationDrawerModifier()`

### Usage

As seen in the ExampleApp, one way to create a navigation drawer with a swipe gesture is
by using the `navigationDrawerModifier` extension function. The view onto which this
modifier is applied should have a fixed frame size.

    GeometryReader() { geometry in
        ZStack(alignment: .topLeading) {
            HomeScreen()
        }
        .frame(width: geometry.size.width,
               height: geometry.size.height)
        .navigationDrawerModifier(geometry: geometry,
                                  uiColor: .systemTeal)
    }
