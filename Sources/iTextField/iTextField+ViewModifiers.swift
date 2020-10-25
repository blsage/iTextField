//
//  iTextField+ViewModifiers.swift
//  
//
//  Created by Benjamin Sage on 10/24/20.
//

import SwiftUI
import UIKit

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
