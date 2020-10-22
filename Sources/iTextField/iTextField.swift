import SwiftUI
import UIKit

@available(iOS 13.0, *)
/// A wrapper **text field** ⌨️ around the `UITextField`, harnessing its fully functionality 💪,
/// that can be used using entirely SwiftUI like an ordinary `TextField`. 😲😃
public struct iTextField: UIViewRepresentable {
    
    private var placeholder: String
    @Binding private var text: String
    @Binding private var isEditing: Bool
    
    private var didBeginEditing: () -> Void = { }
    private var didChange: () -> Void = { }
    private var didEndEditing: () -> Void = { }
    private var shouldReturn: () -> Void = { }
    private var shouldClear: () -> Void = { }
    
    private var font: UIFont?
    private var foregroundColor: UIColor?
    private var accentColor: UIColor?
    private var textAlignment: NSTextAlignment?
    private var contentType: UITextContentType?
    
    private var autocorrection: UITextAutocorrectionType = .default
    private var autocapitalization: UITextAutocapitalizationType = .sentences
    private var keyboardType: UIKeyboardType = .default
    private var returnKeyType: UIReturnKeyType = .default
    
    private var isSecure: Bool = false
    private var isUserInteractionEnabled: Bool = true
    private var clearsOnBeginEditing: Bool = false
    private var clearsOnInsertion: Bool = false
    private var clearButtonMode: UITextField.ViewMode = .never
    
    private var passwordRules: UITextInputPasswordRules?
    private var smartDashesType: UITextSmartDashesType = .default
    private var smartInsertDeleteType: UITextSmartInsertDeleteType = .default
    private var smartQuotesType: UITextSmartQuotesType = .default
    private var spellCheckingType: UITextSpellCheckingType = .default
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    /// Initializes a new **text field** 👷‍♂️⌨️ with enhanced functionality. 🏋️‍♀️
    /// - Parameters:
    ///   - placeholder: The text to display in the text field when nothing has been inputted
    ///   - text: A binding to the text `String` to be edited by the text field 📱
    ///   - isEditing: A binding to a `Bool` indicating whether the text field is being edited 💻💬
    public init(_ placeholder: String,
                text: Binding<String>,
                isEditing: Binding<Bool>)
    {
        self.placeholder = placeholder
        self._text = text
        self._isEditing = isEditing
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        // Validating and Handling Edits
        textField.delegate = context.coordinator
        
        // Accessing the Text Attributes
        textField.text = text
        textField.placeholder = placeholder
        textField.font = font
        textField.textColor = foregroundColor
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
        }
        
        // Managing the Editing Behavior
        if isEditing {
            textField.becomeFirstResponder()
        }
        textField.clearsOnBeginEditing = clearsOnBeginEditing
        textField.clearsOnInsertion = clearsOnInsertion
        
        // Other settings
        if let contentType = contentType {
            textField.textContentType = contentType
        }
        if let accentColor = accentColor {
            textField.tintColor = accentColor
        }
        textField.clearButtonMode = clearButtonMode
        textField.autocorrectionType = autocorrection
        textField.autocapitalizationType = autocapitalization
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        
        textField.isSecureTextEntry = isSecure
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textField.passwordRules = passwordRules
        textField.smartDashesType = smartDashesType
        textField.smartInsertDeleteType = smartInsertDeleteType
        textField.smartQuotesType = smartQuotesType
        textField.spellCheckingType = spellCheckingType
        
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text,
                           isEditing: $isEditing,
                           didBeginEditing: didBeginEditing,
                           didChange: didChange,
                           didEndEditing: didEndEditing,
                           shouldReturn: shouldReturn,
                           shouldClear: shouldClear)
    }
    
    public final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        var didBeginEditing: () -> Void
        var didChange: () -> Void
        var didEndEditing: () -> Void
        var shouldReturn: () -> Void
        var shouldClear: () -> Void
        
        init(text: Binding<String>,
             isEditing: Binding<Bool>,
             didBeginEditing: @escaping () -> Void,
             didChange: @escaping () -> Void,
             didEndEditing: @escaping () -> Void,
             shouldReturn: @escaping () -> Void,
             shouldClear: @escaping () -> Void)
        {
            self._text = text
            self._isEditing = isEditing
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
            self.didEndEditing = didEndEditing
            self.shouldReturn = shouldReturn
            self.shouldClear = shouldClear
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                if !isEditing {
                    isEditing = true
                }
                if textField.clearsOnBeginEditing {
                    text = ""
                }
                didBeginEditing()
            }
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
            didChange()
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            DispatchQueue.main.async { [self] in
                if isEditing {
                    isEditing = false
                }
                didEndEditing()
            }
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isEditing = false
            shouldReturn()
            return false
        }
        
        public func textFieldShouldClear(_ textField: UITextField) -> Bool {
            shouldClear()
            text = ""
            return false
        }
    }
}

@available(iOS 13.0, *)
extension iTextField {
    /// Modifies the text field’s **font** from a `UIFont` object. 🔠🔡
    /// - Parameter font: The desired font 🅰️🆗
    /// - Returns: An updated text field using the desired font 💬
    /// - Warning: ⚠️ Accepts a `UIFont` object rather than SwiftUI `Font` ⚠️
    /// - SeeAlso: [`UIFont`](https://developer.apple.com/documentation/uikit/uifont)
    public func fontFromUIFont(_ font: UIFont?) -> iTextField {
        var view = self
        view.font = font
        return view
    }
    
    /// Modifies the **text color** 🎨 of the text field.
    /// - Parameter color: The desired text color 🌈
    /// - Returns: An updated text field using the desired text color 🚦
    @available(iOS 13, *)
    public func foregroundColor(_ color: Color?) -> iTextField {
        var view = self
        if let color = color {
            view.foregroundColor = UIColor.from(color: color)
        }
        return view
    }
    
    /// Modifies the **cursor color** 🌈 of the text field 🖱 💬
    /// - Parameter accentColor: The cursor color 🎨
    /// - Returns: A phone number text field with updated cursor color 🚥🖍
    @available(iOS 13, *)
    public func accentColor(_ accentColor: Color?) -> iTextField {
        var view = self
        if let accentColor = accentColor {
            view.accentColor = UIColor.from(color: accentColor)
        }
        return view
    }
    
    /// Modifies the **text alignment** of a text field. ⬅️ ↔️ ➡️
    /// - Parameter alignment: The desired text alignment 👈👉
    /// - Returns: An updated text field using the desired text alignment ↩️↪️
    public func multilineTextAlignment(_ alignment: TextAlignment) -> iTextField {
        var view = self
        switch alignment {
        case .leading:
            view.textAlignment = layoutDirection ~= .leftToRight ? .left : .right
        case .trailing:
            view.textAlignment = layoutDirection ~= .leftToRight ? .right : .left
        case .center:
            view.textAlignment = .center
        }
        return view
    }
    
    /// Modifies the **content type** of a text field. 📧 ☎️ 📬
    /// - Parameter textContentType: The type of text being inputted into the text field ⌨️
    /// - Returns: An updated text field using the desired text content type 💻📨
    public func textContentType(_ textContentType: UITextContentType?) -> iTextField {
        var view = self
        view.contentType = textContentType
        return view
    }
    
    /// Modifies the text field’s **autocorrection** settings. 💬
    /// - Parameter disable: Whether autocorrection should be disabled ❌
    /// - Returns: An updated text field using the desired autocorrection settings 📝
    public func disableAutocorrection(_ disable: Bool?) -> iTextField {
        var view = self
        if let disable = disable {
            view.autocorrection = disable ? .no : .yes
        } else {
            view.autocorrection = .default
        }
        return view
    }
    
    /// Modifies the text field’s **autocapitalization** style. 🔡🔠
    /// - Parameter style: What types of characters should be autocapitalized
    /// - Returns: An updated text field using the desired autocapitalization style
    public func autocapitalization(_ style: UITextAutocapitalizationType) -> iTextField {
        var view = self
        view.autocapitalization = style
        return view
    }
    
    /// Modifies the text field’s **keyboard type**. 📩🕸🧒
    /// - Parameter type: The type of keyboard that the user should get to type in the text field
    /// - Returns: An updated text field using the desired keyboard type
    public func keyboardType(_ type: UIKeyboardType) -> iTextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    /// Modifies the text field’s **return key** type. 🆗✅
    /// - Parameter type: The type of return key the user should get on the keyboard when using this text field
    /// - Returns: An updated text field using the desired return key type
    public func returnKeyType(_ type: UIReturnKeyType) -> iTextField {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    /// Modifies the text field’s **secure entry** settings. 🔒🚨
    /// - Parameter isSecure: Whether the text field should hide the entered characters as dots
    /// - Returns: An updated text field using the desired secure entry settings
    public func isSecure(_ isSecure: Bool) -> iTextField {
        var view = self
        view.isSecure = isSecure
        return view
    }
    
    /// Modifies the **clear-on-begin-editing** setting of a  text field. ❌▶️
    /// - Parameter shouldClear: Whether the text field should clear on editing beginning 📭🏁
    /// - Returns:  A text field with updated clear-on-begin-editing settings 🔁
    public func clearsOnBeginEditing(_ shouldClear: Bool) -> iTextField {
        var view = self
        view.clearsOnBeginEditing = shouldClear
        return view
    }
    
    
    /// Modifies the **clear-on-insertion** setting of a text field. 👆
    /// - Parameter shouldClear: Whether the text field should clear on insertion
    /// - Returns: A text field with updated clear-on-insertion settings
    public func clearsOnInsertion(_ shouldClear: Bool) -> iTextField {
        var view = self
        view.clearsOnInsertion = shouldClear
        return view
    }
    
    /// Modifies whether and when the text field **clear button** appears on the view. ⭕️ ❌
    /// - Parameter showsButton: Whether the clear button should be visible
    /// - Returns: A text field with updated clear button settings
    public func showsClearButton(_ showsButton: Bool) -> iTextField {
        var view = self
        view.clearButtonMode = showsButton ? .always : .never
        return view
    }
    
    /// Modifies whether the text field is **disabled**. ✋
    /// - Parameter disabled: Whether the text field is disabled 🛑
    /// - Returns: A text field with updated disabled settings ⬜️⚙️
    public func disabled(_ disabled: Bool) -> iTextField {
        var view = self
        view.isUserInteractionEnabled = !disabled
        return view
    }
    
    public func passwordRules(_ rules: UITextInputPasswordRules) -> iTextField {
        var view = self
        view.passwordRules = rules
        return view
    }
    
    public func smartDashes(_ smartDashes: Bool?) -> iTextField {
        var view = self
        if let smartDashes = smartDashes {
            view.smartDashesType = smartDashes ? .yes : .no
        }
        return view
    }
    
    public func smartInsertDeleteType(_ smartInsertDelete: Bool?) -> iTextField {
        var view = self
        if let smartInsertDelete = smartInsertDelete {
            view.smartInsertDeleteType = smartInsertDelete ? .yes : .no
        }
        return view
    }
    
    public func smartQuotes(_ smartQuotes: Bool?) -> iTextField {
        var view = self
        if let smartQuotes = smartQuotes {
            view.smartQuotesType = smartQuotes ? .yes : .no
        }
        return view
    }
    
    /// Modifies whether the text field should check the user's **spelling** 🔡
    /// - Parameter spellChecking: Whether the text field should check the user's spelling
    /// - Returns: A text field with updated spell checking settings
    public func spellChecking(_ spellChecking: Bool?) -> iTextField {
        var view = self
        if let spellChecking = spellChecking {
            view.spellCheckingType = spellChecking ? .yes : .no
        }
        return view
    }
    
    /// Modifies the function called when text editing **begins**. ▶️
    /// - Parameter action: The function called when text editing begins 🏁
    /// - Returns: An updated text field using the desired function called when text editing begins ➡️
    public func onEditingBegan(_ action: @escaping () -> Void) -> iTextField {
        var view = self
        view.didBeginEditing = action
        return view
        
    }
    
    /// Modifies the function called when the user makes any **changes** to the text in the text field. 💬
    /// - Parameter action: The function called when the user makes any changes to the text in the text field ⚙️
    /// - Returns: An updated text field using the desired function called when the user makes any changes to the text in the text field 🔄
    public func onEdit(_ action: @escaping () -> Void) -> iTextField {
        var view = self
        view.didChange = action
        return view
        
    }
    
    /// Modifies the function called when text editing **ends**. 🔚
    /// - Parameter action: The function called when text editing ends 🛑
    /// - Returns: An updated text field using the desired function called when text editing ends ✋
    public func onEditingEnded(_ action: @escaping () -> Void) -> iTextField {
        var view = self
        view.didEndEditing = action
        return view
    }
    
    
    /// Modifies the function called when the user presses the return key. ⬇️ ➡️
    /// - Parameter action: The function called when the user presses the return key
    /// - Returns: An updated text field using the desired funtion called when the user presses the return key
    public func onReturn(_ action: @escaping () -> Void) -> iTextField {
        var view = self
        view.shouldReturn = action
        return view
    }
    
    /// Modifies the function called when the user clears the text field. ❌
    /// - Parameter action: The function called when the user clears the text field
    /// - Returns: An updated text field using the desired function called when the user clears the text field
    public func onClear(_ action: @escaping () -> Void) -> iTextField {
        var view = self
        view.shouldClear = action
        return view
    }
    
    /// Since Apple has not given us a way yet to parse a `Font` 🔠🔡  object, this function must be deprecated 😔. Please use `.fontFromUIFont(_:)` instead 🙂.
    /// - Parameter font:
    /// - Returns:
    @available(*, deprecated, renamed: "fontFromUIFont", message: "At this time, Apple will not let us parse a `Font` object❗️ Please use `.fontFromUIFont(_:)` instead.")
    public func font(_ font: Font?) -> some View { return EmptyView() }
    
    @available(*, deprecated, message: "If you would like to change they keyboard ⌨️ please email 📧 me (benjaminlsage@gmail.com). I didn't think anyone would need to 🙂.")
    public func keyboardType(_ type: UIKeyboardType) -> some View { return EmptyView() }
}

@available(iOS 13, *)
fileprivate extension UIColor {
    class func from(color: Color) -> UIColor {
        if #available(iOS 14, *) {
            return UIColor(color)
        } else {
            let scanner = Scanner(string: color.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            var hexNumber: UInt64 = 0
            var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
            
            let result = scanner.scanHexInt64(&hexNumber)
            if result {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
            
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
}
