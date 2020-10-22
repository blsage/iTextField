# iTextField

### A fully-wrapped `UITextField` that works entirely in SwiftUI ⌨️

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate?hosted_button_id=BH9BEVARXWWFC)

<img src="Demo/iTextFieldDemo1Light.gif" alt="drawing" width="250"/>

1. [Install](https://github.com/benjaminsage/iTextField/blob/master/INSTALL.md) `iTextField`
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
`.fontFromUIFont(font: UIFont?) -> iTextField` | Modifies the text field’s **font** from a `UIFont` object. 🔠 🔡
`.foregroundColor(color: Color?) -> iTextField` | Modifies the **text color** 🎨 of the text field.
`.accentColor(accentColor: Color?) -> iTextField` | Modifies the **cursor color** 🌈 of the text field 🖱 💬
`.multilineTextAlignment(alignment: TextAlignment) -> iTextField` | Modifies the **text alignment** of a text field. ⬅️ ↔️ ➡️
`.textContentType(textContentType: UITextContentType?) -> iTextField` | Modifies the **content type** of a text field. 📧 ☎️ 📬
`.disableAutocorrection(disable: Bool?) -> iTextField` | Modifies the text field’s **autocorrection** settings. 💬
`.keyboardType(type: UIKeyboardType) -> iTextField` | Modifies the text field’s **keyboard type**. 📩 🕸 🧒
`.autocapitalization(style: UITextAutocapitalizationType) -> iTextField` | Modifies the text field’s **autocapitalization** style. 🔡 🔠
`.returnKeyType(type: UIReturnKeyType) -> iTextField` | Modifies the text field’s **return key** type. 🆗 ✅
`.isSecure(isSecure: Bool) -> iTextField` | Modifies the text field’s **secure entry** settings. 🔒 🚨
`.clearsOnBeginEditing(shouldClear: Bool) -> iTextField` | Modifies the **clear-on-begin-editing** setting of a text field. ❌ ▶️
`clearsOnInsertion(_ shouldClear: Bool) -> iTextField` | Modifies the **clear-on-insertion** setting of a text field. 👆
`.disabled(disabled: Bool) -> iTextField` | Modifies whether the text field is **disabled**. ✋
`spellChecking(_ spellChecking: Bool?) -> iTextField` | Modifies whether the text field should check the user's **spelling** 🔡
`.onEditingBegan(action: { code }) -> iTextField` | Modifies the function called when text editing **begins**. ▶️
`.onEdit(_ action: { code }) -> iTextField` | Modifies the function called when the user makes any **changes** to the text in the text field. 💬
`.onEditingEnded(_ action: { code }) -> iTextField` | Modifies the function called when text editing **ends**. 🔚
`onReturn(_ action: { code }) -> iTextField` | Modifies the function called when the user presses the return key. ⬇️ ➡️
`onClear(_ action: { code }) -> iTextField` | Modifies the function called when the user clears the text field. ❌