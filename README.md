# SwiftUIUtils

This repository contains a collection of custom views, extensions, helper functions, delegates, and modifiers for SwiftUI. These components are intended to make it easier to develop SwiftUI apps by simplifying common tasks, adding new functionality, and improving the user experience.

## Installation

To use these components in your own SwiftUI project, you can simply add the `SwiftUIUtils` package as a dependency. To do so, add the following line to your project's `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/izubairsh/SwiftUIUtils.git", from: "1.0.0")
]
```

Alternatively, you can also add the SwiftUIUtils package as a dependency using Xcode. To do so, open your project in Xcode, navigate to the "Swift Packages" tab in the project settings, and click the "+" button to add a new package. Enter the URL of this repository and choose the appropriate version.

## Usage
The SwiftUIUtils package contains a variety of custom views, extensions, helper functions, delegates, and modifiers for SwiftUI, including:

### Custom Views
CircularProgressView - a circular progress view with customizable colors and animation
GradientButton - a button with a gradient background and customizable colors and action

### Extensions
Color+Hex - an extension that allows you to create a Color from a hex code string
Image+Color - an extension that allows you to create an Image from a solid color
View+DismissKeyboard - an extension that adds a tap gesture recognizer to dismiss the keyboard when tapping outside of a text field

### Delegates
DragRelocateDelegate - is a custom delegate that can be used with SwiftUI's `DragGesture` to enable dragging and reordering of a list of views. When you apply the `DragGesture` to a view and set its delegate to `DragRelocateDelegate`, users can drag and relocate the view within the list by tapping and holding the view and then dragging it to a new location.

### Modifiers
FullWidthModifier - that expands a view to the full width of its parent container.

To use these components in your own SwiftUI code, simply import the SwiftUIUtils module at the top of your file:

```swift
import SwiftUIUtils
```

Then, you can use any of the components listed above in your SwiftUI code.

## Contributing
Contributions to this repository are welcome and encouraged! If you have an idea for a new component, or an improvement to an existing component, please open a pull request.
