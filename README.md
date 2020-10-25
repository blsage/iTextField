<h1 align="center"> iTextField📖</p>
<h3 align="center"> A fully-wrapped `UITextField` that works entirely in SwiftUI ⌨️ </h3>
<p align="center">
    <strong><a href="#get-started">Get Started</a></strong> |
    <strong><a href="#examples">Examples</a></strong> |
    <strong><a href="#customize">Customize</a></strong> |
    <strong><a href="#install">Install</a></strong> | 
    <strong><a href="#usage">Usage</a></strong>
</p>
<p align="center">
    <img src="https://github.com/AlexFine/SwiftUICode/blob/master/public/assets/img/iTextField3.gif" alt="CI" />
</p>

<br/>


## Get Started

1. [Install](https://github.com/benjaminsage/iTextField/blob/master/INSTALL.md) `iTextField`
2. Add `iTextField` to your project
```swift
import SwiftUI
import iTextField

struct ContentView: View {
    @State var text: String = ""

    var body: some View {
        iTextField("Placeholder",
                   text: $text)
    }
}
```
3. Customize your `iTextfield`


## Examples
### Starter
<img src="Demo/iTextFieldDemo1Light.gif" alt="drawing" width="250"/>
Customize your text field with built-in modifiers.

```swift
import SwiftUI
import iTextField

struct ContentView: View {
    @State var text: String = ""

    var body: some View {
        iTextField("Placeholder", text: $text)
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

### Jump text fields
Use the optional `isEditing` binding parameter to programmatically jump between text fields.
```swift
import SwiftUI
import iTextField

struct ContentView: View {
    @State var text1: String = ""
    @State var text2: String = ""
    @State var isSecondEditing: String = ""

    var body: some View {
        iTextField("First", text: $text1)
            .onReturn { isSecondEditing = true }
        iTextField("Second", text: $text2,
                   isEditing: $isSecondEditing)
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
`.fontFromUIFont(_ font: UIFont?) -> iTextField` | Modifies the text field’s **font** from a `UIFont` object. 🔠
`.foregroundColor(_ color: Color?) -> iTextField` | Modifies the **text color** 🎨 of the text field.
`.accentColor(_ accentColor: Color?) -> iTextField` | Modifies the **cursor color** 🌈 of the text field
`.multilineTextAlignment(_ alignment: TextAlignment) -> iTextField` | Modifies the **text alignment** of a text field. ↔️
`.textContentType(_ textContentType: UITextContentType?) -> iTextField` | Modifies the **content type** of a text field. 📧 ☎️
`.disableAutocorrection(_ disable: Bool?) -> iTextField` | Modifies the text field’s **autocorrection** settings.
`.keyboardType(_ type: UIKeyboardType) -> iTextField` | Modifies the text field’s **keyboard type**. 📩
`.autocapitalization(_ style: UITextAutocapitalizationType) -> iTextField` | Modifies the text field’s **autocapitalization** style. 🔡
`.returnKeyType(_ type: UIReturnKeyType) -> iTextField` | Modifies the text field’s **return key** type. ✅
`.isSecure(_ isSecure: Bool) -> iTextField` | Modifies the text field’s **secure entry** settings. 🔒
`.clearsOnBeginEditing(_ shouldClear: Bool) -> iTextField` | Modifies the **clear-on-begin-editing** setting of a text field. ❌
`clearsOnInsertion(_ shouldClear: Bool) -> iTextField` | Modifies the **clear-on-insertion** setting of a text field. 👆
`.showsClearButton(_ showsButton: Bool) -> iTextField` | Modifies whether and when the text field **clear button** appears on the view. ⭕️ ❌
`.passwordRules(_ rules: UITextInputPasswordRules) -> iTextField` | Modifies the text field's **password rules** 🔒. Sets secure entry to `true`.
`.spellChecking(_ spellChecking: Bool?) -> iTextField` | Modifies whether the text field should check the user's **spelling**.
`.smartDashes(_ smartDashes: Bool?) -> iTextField` | Modifies whether the text field includes **smart dashes**.
`.smartInsertDelete(_ smartInsertDelete: Bool? = nil) -> iTextField` | Modifies whether the text field uses **smart insert-delete**.
`.smartQuotes(_ smartQuotes: Bool? = nil) -> iTextField` | Modifies whether the text field uses **smart quotes**.
`.disabled(disabled: Bool) -> iTextField` | Modifies whether the text field is **disabled**. ✋
`.onEditingBegan(perform action: { code }) -> iTextField` | Modifies the function called when text editing **begins**. ▶️
`.onEdit(perform action: { code }) -> iTextField` | Modifies the function called when the user makes any **changes** to the text in the text field. 💬
`.onEditingEnded(perform action: { code }) -> iTextField` | Modifies the function called when text editing **ends**. 🔚
`.onReturn(perform action: { code }) -> iTextField` | Modifies the function called when the user presses the return key. ⬇️ ➡️
`.onClear(perform action: { code }) -> iTextField` | Modifies the function called when the user clears the text field. ❌

## Install 
Use the Swift package manager to install. Find instructions [here](https://github.com/benjaminsage/iPages/blob/main/INSTALL.md)😀


## Usage
<b>iTextField is FREE and open-source for individuals, and will remain that way forever. </b>

iTextField is distributed under a GNU GPL open-source license. 

Commercial users, please note, this license is often <b><a href="https://en.wikipedia.org/wiki/GNU_General_Public_License#Legal_barrier_to_app_stores">incompatible for many commercial applications</a></b>. If your app is distributed for commercial use, it could violate this open-source license even "if the application is free in the App Store". 

In order to offer iTextField safely to our commercial friends we made it easy to purchase a lifetime, full-use license for $4.99. Code on worry free 😁 

<p align="center"><a href="https://general099748.typeform.com/to/p5FtTKBj"> <img src="https://github.com/AlexFine/SwiftUICode/blob/master/public/assets/img/Purchase%20License.png" width="300"> </a> </p>

