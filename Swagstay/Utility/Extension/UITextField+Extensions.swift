

import Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()

public extension UITextField {
    /// - SwifterSwift: UITextField text type.
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        /// SwifterSwift: UITextField is used to enter email addresses.
        case emailAddress

        /// SwifterSwift: UITextField is used to enter passwords.
        case password

        /// SwifterSwift: UITextField is used to enter generic text.
        case generic
    }
}



// MARK: - Methods
public extension UITextField {
    /// SwifterSwift: Clear text.
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SwifterSwift: Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }

    /// SwifterSwift: Add padding to the right of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }

    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
    }

    /// SwifterSwift: Add padding to the right of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: right image
    ///   - padding: amount of padding between icon and the right of textfield
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }
}


@IBDesignable
class RoundTextField : UITextField {
    
    @IBInspectable var leftImage: UIImage? = nil
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var gapPadding: CGFloat = 0
    
    private var textPadding: UIEdgeInsets {
        let p: CGFloat = leftPadding + gapPadding + (leftView?.frame.width ?? 0)
        return UIEdgeInsets(top: 0, left: p, bottom: 0, right: 5)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var r = super.leftViewRect(forBounds: bounds)
            r.origin.x += leftPadding
            return r
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        private func setup() {
            if let image = leftImage {
                if leftView != nil { return } // critical!
                
                let im = UIImageView()
                im.contentMode = .scaleAspectFill
                im.image = image
                
                leftViewMode = UITextField.ViewMode.always
                leftView = im
                
            } else {
                leftViewMode = UITextField.ViewMode.never
                leftView = nil
            }
        }
    
    @IBInspectable var placeholderColor : UIColor? {
           didSet {
               let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor!])
               attributedPlaceholder = str
           }
       }
}



// MARK: - Properties
public extension UITextField {
    /// SwifterSwift: Set textField for common text types.
    var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                placeholder = "Email Address"

            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                placeholder = "Password"

            case .generic:
                isSecureTextEntry = false
            }
        }
    }

    /// SwifterSwift: Check if text field is empty.
    var isEmpty: Bool {
        return text?.isEmpty == true
    }

    /// SwifterSwift: Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// SwifterSwift: Check if textFields text is a valid email format.
    ///
    ///        textField.text = "john@doe.com"
    ///        textField.hasValidEmail -> true
    ///
    ///        textField.text = "swifterswift"
    ///        textField.hasValidEmail -> false
    ///
    var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }

    /// SwifterSwift: Left view tint color.
    @IBInspectable var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }

    /// SwifterSwift: Right view tint color.
    @IBInspectable var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
           get {
               return leftView!.frame.size.width
           }
           set {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
               leftView = paddingView
               leftViewMode = .always
           }
       }

       @IBInspectable var paddingRightCustom: CGFloat {
           get {
               return rightView!.frame.size.width
           }
           set {
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
               rightView = paddingView
               rightViewMode = .always
           }
       }
    
    @IBInspectable var maxLength: Int {
            get {
                guard let l = __maxLengths[self] else {
                   return 150 // (global default-limit. or just, Int.max)
                }
                return l
            }
            set {
                __maxLengths[self] = newValue
                addTarget(self, action: #selector(fix), for: .editingChanged)
            }
        }
    @objc func fix(textField: UITextField) {
            let t = textField.text
        textField.text = String((t?.prefix(maxLength))!)
        }
}
