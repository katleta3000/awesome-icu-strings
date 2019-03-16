import Foundation

/*:
Many strings and unicode transformations use ICU on the low level. iOS system includes libICU.
You may use some [ICU](http://site.icu-project.org/) transforms via String.applyingTransform.
*/

if let transcriptesString = "матрёшка".applyingTransform(.toLatin, reverse: false) {
	print(transcriptesString)
	print(transcriptesString.applyingTransform(.stripDiacritics, reverse: false) ?? transcriptesString)
}
print("🌍".applyingTransform(.toUnicodeName, reverse: false) ?? "🌍")

/*:
There are 16 standart transforms (you may find them [here](https://developer.apple.com/documentation/foundation/stringtransform), but there are many others if you just create your own rule according to the ICU standart.
Let's add the category below for demonstating true power of ICU transforms.

````
extension String {
	func transformed(with rule: String, reverse: Bool = false) -> String {
		return self.applyingTransform(
			StringTransform(rawValue: rule),
			reverse: reverse
		) ?? self
	}
}
````
*/

//: [Next](@next)
