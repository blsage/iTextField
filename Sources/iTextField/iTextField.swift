import SwiftUI
import UIKit

@available(iOS 13.0, *)
/// A wrapper **text field** ⌨️ around the `UITextField`, harnessing its fully functionality 💪,
/// that can be used using entirely SwiftUI like an ordinary `TextField`. 😲😃
public struct iTextField: UIViewRepresentable {
    
    private var placeholder: String
    @Binding private var text: String
    
    @State private var internalIsEditing = false
    @Binding private var externalIsEditing: Bool
    private var isEditing: Binding<Bool> {
        hasExternalIsEditing ? $externalIsEditing : $internalIsEditing
    }
    private var hasExternalIsEditing = false
    var designEditing: Bool { externalIsEditing }
    
    var didBeginEditing: () -> Void = { }
    var didChange: () -> Void = { }
    var didEndEditing: () -> Void = { }
    var shouldReturn: () -> Void = { }
    var shouldClear: () -> Void = { }
    
    var font: UIFont?
    var foregroundColor: UIColor?
    var accentColor: UIColor?
    var textAlignment: NSTextAlignment?
    var contentType: UITextContentType?
    
    var autocorrection: UITextAutocorrectionType = .default
    var autocapitalization: UITextAutocapitalizationType = .sentences
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    
    var isSecure = false
    var isUserInteractionEnabled = true
    var clearsOnBeginEditing = false
    var clearsOnInsertion = false
    var clearButtonMode: UITextField.ViewMode = .never
    
    var passwordRules: UITextInputPasswordRules?
    var smartDashesType: UITextSmartDashesType = .default
    var smartInsertDeleteType: UITextSmartInsertDeleteType = .default
    var smartQuotesType: UITextSmartQuotesType = .default
    var spellCheckingType: UITextSpellCheckingType = .default
    
    @Environment(\.layoutDirection) var layoutDirection: LayoutDirection
    @Environment(\.colorScheme) var colorScheme: ColorScheme
        
    /// Initializes a new **text field** 👷‍♂️⌨️ with enhanced functionality. 🏋️‍♀️
    /// - Parameters:
    ///   - placeholder: The text to display in the text field when nothing has been inputted
    ///   - text: A binding to the text `String` to be edited by the text field 📱
    ///   - isEditing: A binding to a `Bool` indicating whether the text field is being edited 💻💬
    public init(_ placeholder: String,
                text: Binding<String>,
                isEditing: Binding<Bool>? = nil)
    {
        self.placeholder = placeholder
        self._text = text
        if let isEditing = isEditing {
            _externalIsEditing = isEditing
            hasExternalIsEditing = true
        } else {
            _externalIsEditing = Binding<Bool>(get: { false }, set: { _ in })
        }
    }
    
    /// All these properties need to be set in exactly the same way to make the UIView and to update the UIView
    private func setProperties(_ textField: UITextField) {
        // Accessing the Text Attributes
        textField.text = text
        textField.placeholder = placeholder
        textField.font = font
        textField.textColor = foregroundColor
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
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
        
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textField.passwordRules = passwordRules
        textField.smartDashesType = smartDashesType
        textField.smartInsertDeleteType = smartInsertDeleteType
        textField.smartQuotesType = smartQuotesType
        textField.spellCheckingType = spellCheckingType
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        // Validating and Handling Edits
        textField.delegate = context.coordinator
        
        setProperties(textField)
        
        textField.isSecureTextEntry = isSecure

        // Managing the Editing Behavior
        if isEditing.wrappedValue {
            textField.becomeFirstResponder()
        }
        
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }
    
    public func updateUIView(_ textField: UITextField, context: Context) {
        setProperties(textField)
        
        /// # Handling the toggling of isSecure correctly
        ///
        /// To ensure that the cursor position is maintained when toggling secureTextEntry
        /// we can read the cursor position before updating the property and set it back afterwards.
        ///
        /// UITextField also deletes all the existing text whenever secureTextEntry goes from false to true.
        /// We work around that by procedurely removing and re-adding the text here.
        
        if isSecure != textField.isSecureTextEntry {
            var start: UITextPosition?
            var end: UITextPosition?
            
            if let selectedRange = textField.selectedTextRange {
                start = selectedRange.start
                end = selectedRange.end
            }

            textField.isSecureTextEntry = isSecure
            if isSecure && isEditing.wrappedValue {
                if let currentText = textField.text {
                    textField.text?.removeAll()
                    textField.insertText(currentText)
                }
            }
            if isEditing.wrappedValue {
                if let start = start, let end = end {
                    textField.selectedTextRange = textField.textRange(from: start, to: end)
                }
            }
        }

        if isEditing.wrappedValue {
            textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text,
                           isEditing: isEditing,
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
