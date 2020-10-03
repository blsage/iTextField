import SwiftUI
import UIKit

@available(iOS 14.0, *)
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

@available(iOS 14.0, *)
extension TextFieldView {
    func font(_ font: UIFont?) -> TextFieldView {
        var view = self
        view.font = font
        return view
    }
    
    func foregroundColor(_ color: Color?) -> TextFieldView {
        var view = self
        if let color = color {
            view.foregroundColor = UIColor(color)
        }
        return view
    }
    
    func accentColor(_ accentColor: Color?) -> TextFieldView {
        var view = self
        if let accentColor = accentColor {
            view.accentColor = UIColor(accentColor)
        }
        return view
    }
    
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
    
    func textContentType(_ textContentType: UITextContentType?) -> TextFieldView {
        var view = self
        view.contentType = textContentType
        return view
    }
    
    func disableAutocorrection(_ disable: Bool?) -> TextFieldView {
        var view = self
        if let disable = disable {
            view.autocorrection = disable ? .no : .yes
        } else {
            view.autocorrection = .default
        }
        return view
    }
    
    func autocapitalization(_ style: UITextAutocapitalizationType) -> TextFieldView {
        var view = self
        view.autocapitalization = style
        return view
    }
    
    func keyboardType(_ type: UIKeyboardType) -> TextFieldView {
        var view = self
        view.keyboardType = type
        return view
    }
    
    func returnKeyType(_ type: UIReturnKeyType) -> TextFieldView {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    func isSecure(_ isSecure: Bool) -> TextFieldView {
        var view = self
        view.isSecure = isSecure
        return view
    }
    
    func clearsOnBeginEditing(_ shouldClear: Bool) -> TextFieldView {
        var view = self
        view.clearsOnBeginEditing = shouldClear
        return view
    }
    
    func disabled(_ disabled: Bool) -> TextFieldView {
        var view = self
        view.isUserInteractionEnabled = disabled
        return view
    }
}
