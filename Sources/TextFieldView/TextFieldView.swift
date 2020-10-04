import SwiftUI
import UIKit

@available(iOS 13.0, *)
/// A view representable wrapper around the `UITextField`, harnessing its fully functionality,
/// that can be used using entirely SwiftUI like an ordinary `TextField`
struct TextFieldView: UIViewRepresentable {
    
    var placeholder: String
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var didBeginEditing: () -> Void = { }
    var didChange: () -> Void = { }
    var didEndEditing: () -> Void = { }
    
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
    
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    
    /// Initializes the text field with the required parameters
    /// - Parameters:
    ///   - placeholder: The text to display in the text field when nothing has been inputted
    ///   - text: A binding to the text `String` to be edited by the text field
    ///   - isEditing: A binding to a `Bool` indicating whether the text field is being edited
    ///   - didBeginEditing: A function called when text editing begins
    ///   - didChange: A function called when the user makes any changes to the text in the text field
    ///   - didEndEditing: A function called when text editing ends
    init(_ placeholder: String,
         text: Binding<String>,
         isEditing: Binding<Bool>,
         didBeginEditing: @escaping () -> Void = { },
         didChange: @escaping () -> Void = { },
         didEndEditing: @escaping () -> Void = { })
    {
        self.placeholder = placeholder
        self._text = text
        self._isEditing = isEditing
        self.didBeginEditing = didBeginEditing
        self.didChange = didChange
        self.didEndEditing = didEndEditing
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.delegate = context.coordinator
        
        textField.placeholder = placeholder
        textField.text = text
        textField.font = font
        textField.textColor = foregroundColor
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
        }
        if let contentType = contentType {
            textField.textContentType = contentType
        }
        if let accentColor = accentColor {
            textField.tintColor = accentColor
        }
        textField.autocorrectionType = autocorrection
        textField.autocapitalizationType = autocapitalization
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        
        textField.clearsOnBeginEditing = clearsOnBeginEditing
        textField.isSecureTextEntry = isSecure
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        if isEditing {
            textField.becomeFirstResponder()
        }
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text,
                           isEditing: $isEditing,
                           didBeginEditing: didEndEditing,
                           didChange: didChange,
                           didEndEditing: didEndEditing)
    }
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        var didBeginEditing: () -> Void
        var didChange: () -> Void
        var didEndEditing: () -> Void
        
        init(text: Binding<String>, isEditing: Binding<Bool>, didBeginEditing: @escaping () -> Void, didChange: @escaping () -> Void, didEndEditing: @escaping () -> Void) {
            self._text = text
            self._isEditing = isEditing
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
            self.didEndEditing = didEndEditing
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                if !self.isEditing {
                    self.isEditing = true
                }
                self.didEndEditing()
            }
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
            didChange()
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            DispatchQueue.main.async {
                if self.isEditing {
                    self.isEditing = false
                }
                self.didEndEditing()
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isEditing = false
            return false
        }
    }
    
}

@available(iOS 13.0, *)
extension TextFieldView {
    /// Modifies the text field’s font
    /// - Parameter font: The desired font
    /// - Returns: An updated text field using the desired font
    /// - Warning: Accepts a `UIFont` object rather than SwiftUI `Font`
    func font(_ font: UIFont?) -> TextFieldView {
        var view = self
        view.font = font
        return view
    }
    
    /// Modifies the text field text color
    /// - Parameter color: The desired text color
    /// - Returns: An updated text field using the desired text color
    @available(iOS 14, *)
    func foregroundColor(_ color: Color?) -> TextFieldView {
        var view = self
        if let color = color {
            view.foregroundColor = UIColor(color)
        }
        return view
    }
    
    /// Modifies the text field’s cursor and highlight color
    /// - Parameter accentColor: The desired accent color
    /// - Returns: An updated text field using the desired accent color
    @available(iOS 14, *)
    func accentColor(_ accentColor: Color?) -> TextFieldView {
        var view = self
        if let accentColor = accentColor {
            view.accentColor = UIColor(accentColor)
        }
        return view
    }
    
    /// Modifies the text field’s text color
    /// - Parameter color: The desired text color
    /// - Returns: An updated text field using the desired text color
    /// - Warning: Uses UIKit's `UIColor` rather than SwiftUI's `Color`
    func foregroundColor(_ color: UIColor?) -> TextFieldView {
        var view = self
        view.foregroundColor = color
        return view
    }
    
    /// Modifies the text field’s cursor and highlight color
    /// - Parameter accentColor: The desired accent color
    /// - Returns: And updated text field using the desired accent color
    /// - Warning: Uses UIKit's `UIColor` rather than SwiftUI's `Color`
    func accentColor(_ accentColor: UIColor?) -> TextFieldView {
        var view = self
        view.accentColor = accentColor
        return view
    }
    
    /// Modifies the text field’s text alignment
    /// - Parameter alignment: The desired text alignment
    /// - Returns: An updated text field using the desired text alignment
    func multilineTextAlignment(_ alignment: TextAlignment) -> TextFieldView {
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
    
    /// Modifies the text field’s text content type
    /// - Parameter textContentType: The type of text being inputted into the text field
    /// - Returns: An updated text field using the desired text content type
    func textContentType(_ textContentType: UITextContentType?) -> TextFieldView {
        var view = self
        view.contentType = textContentType
        return view
    }
    
    /// Modifies the text field’s autocorrection settings
    /// - Parameter disable: Whether autocorrection should be disabled
    /// - Returns: An updated text field using the desired autocorrection settings
    func disableAutocorrection(_ disable: Bool?) -> TextFieldView {
        var view = self
        if let disable = disable {
            view.autocorrection = disable ? .no : .yes
        } else {
            view.autocorrection = .default
        }
        return view
    }
    
    /// Modifies the text field’s autocapitalization style
    /// - Parameter style: What types of characters should be autocapitalized
    /// - Returns: An updated text field using the desired autocapitalization style
    func autocapitalization(_ style: UITextAutocapitalizationType) -> TextFieldView {
        var view = self
        view.autocapitalization = style
        return view
    }
    
    /// Modifies the text field’s keyboard type
    /// - Parameter type: The type of keyboard that the user should get to type in the text field
    /// - Returns: An updated text field using the desired keyboard type
    func keyboardType(_ type: UIKeyboardType) -> TextFieldView {
        var view = self
        view.keyboardType = type
        return view
    }
    
    /// Modifies the text field’s return key type
    /// - Parameter type: The type of return key the user should get on the keyboard when using this text field
    /// - Returns: An updated text field using the desired return key type
    func returnKeyType(_ type: UIReturnKeyType) -> TextFieldView {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    /// Modifies the text field’s secure entry settings
    /// - Parameter isSecure: Whether the text field should hide the entered characters as dots
    /// - Returns: An updated text field using the desired secure entry settings
    func isSecure(_ isSecure: Bool) -> TextFieldView {
        var view = self
        view.isSecure = isSecure
        return view
    }
    
    /// Modifies the text field’s clear-on-begin-editing settings
    /// - Parameter shouldClear: Whether the text field should clear when the user begins editing
    /// - Returns: An updated text field using the desired clear-on-begin-editing settings
    func clearsOnBeginEditing(_ shouldClear: Bool) -> TextFieldView {
        var view = self
        view.clearsOnBeginEditing = shouldClear
        return view
    }
    
    /// Modifies the text field’s editing disabled settings
    /// - Parameter disabled: Whether the text field should be disabled to user input
    /// - Returns: An updated text field using the desired disabled settings
    func disabled(_ disabled: Bool) -> TextFieldView {
        var view = self
        view.isUserInteractionEnabled = disabled
        return view
    }
}
