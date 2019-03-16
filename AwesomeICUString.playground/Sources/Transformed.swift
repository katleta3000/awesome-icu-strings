import Foundation

public extension String {
	func transformed(with rule: String, reverse: Bool = false) -> String {
		return self.applyingTransform(StringTransform(rawValue: rule), reverse: reverse) ?? self
	}
}
