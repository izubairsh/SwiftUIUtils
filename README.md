# SwiftUIUtils

This repository contains a collection of custom views, extensions, helper functions, delegates, and modifiers for SwiftUI. These components are intended to make it easier to develop SwiftUI apps by simplifying common tasks, adding new functionality, and improving the user experience.

## Installation

To use these components in your own SwiftUI project, you can simply add the `SwiftUIUtils` package as a dependency. To do so, add the following line to your project's `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/izubairsh/SwiftUIUtils.git", from: "1.0.0")
]

Alternatively, you can also add the SwiftUIUtils package as a dependency using Xcode. To do so, open your project in Xcode, navigate to the "Swift Packages" tab in the project settings, and click the "+" button to add a new package. Enter the URL of this repository and choose the appropriate version.

## Usage
The SwiftUICustomComponents package contains a variety of custom views, extensions, helper functions, delegates, and modifiers for SwiftUI, including:

### Custom Views
CircularProgressView - a circular progress view with customizable colors and animation
GradientButton - a button with a gradient background and customizable colors and action

### Extensions
Color+Hex - an extension that allows you to create a Color from a hex code string
Image+Color - an extension that allows you to create an Image from a solid color
View+DismissKeyboard - an extension that adds a tap gesture recognizer to dismiss the keyboard when tapping outside of a text field

### Helper Functions
applyDropShadow() - applies a drop shadow to a view
createGradient() - creates a gradient background for a view
makeRounded() - rounds the corners of a view
scaleEffectOnTap() - scales a view on tap
slideInFrom() - animates a view's entrance from a given direction
toggleStyle() - creates a custom toggle style for a Toggle view

### Delegates
KeyboardAwareDelegate - a delegate that adjusts the view's position when the keyboard appears or disappears

### Modifiers
CardModifier - a modifier that applies a card-style background to a view
GradientBackgroundModifier - a modifier that applies a gradient background to a view
RoundedCornersModifier - a modifier that rounds the corners of a view
ScaleOnTapModifier - a modifier that scales a view on tap
To use these components in your own SwiftUI code, simply import the SwiftUIUtils module at the top of your file:

```swift
import SwiftUICustomComponents

Then, you can use any of the components listed above in your SwiftUI code.

## Contributing
Contributions to this repository are welcome and encouraged! If you have an idea for a new component, or an improvement to an existing component, please open a pull request.
