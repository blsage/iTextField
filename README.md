# iTextField

A fully-wrapped `UITextField` that works entirely in SwiftUI

1. Install `iTextField`
2. Add `iTextField` to your project
```swift
import SwiftUI
import iTextField

struct ContentView: View {
    @State var text: String = ""
    @State var isEditing: Bool = false

    var body: some View {
        iTextField("Placeholder",
                   text: $text,
                   isEditing: $isEditing)
    }
}
```
3. Customize your `iTextfield`


## Examples
### Starter
Customize your text field with built-in modifiers.
```swift
import SwiftUI
import iTextField

struct ContentView: View {
    @State var text: String = ""
    @State var isEditing: Bool = false

    var body: some View {
        iTextField("Placeholder", text: $text, isEditing: $isEditing)
            .accentColor(.purple)
            .fontFromUIFont(UIFont(name: "Avenir", size: 40))
            .keyboardType(.URL)
            .returnKeyType(.done)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
    }
}
```


## Customize
`iTextField` has three required parameters: 1️⃣ a placeholder, 2️⃣ a `text` state, and 3️⃣ an `isEditing` state. iTextField also supports a variety of modifiers.

**Example**: Change the foreground color, accent color, and text alignment with the following code block:
```swift
iTextField("Placeholder", text: $text, isEditing: $isEditing)
    .foregroundColor(.purple)
    .accentColor(.green)
    .multilineTextAlignment(.leading)
```

Use this exhaustive input list to customize your text field.

Modifier | Description
--- | ---