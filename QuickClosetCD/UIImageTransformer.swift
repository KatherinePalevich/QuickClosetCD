import UIKit

@objc(UIImageTransformer)
final class UIImageTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: UIImageTransformer.self))

  override static var allowedTopLevelClasses: [AnyClass] {
        return [UIImage.self]
    }

    /// Registers the transformer.
    public static func register() {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: name)
    }
}
