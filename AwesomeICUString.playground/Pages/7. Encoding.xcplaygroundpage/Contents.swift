import UIKit

/*:
You've definetely had this problem if you worked with XML data from backend.
You received an encoded string and need to get the non-escaped symbols.
There are 5 special XML characters: &<>'"
*/

let xmlString = "&#x26;&#x3C;&#x3E;&#x27;&#x22;"

/*:
You may use code like that:
*/

print(xmlString
	.replacingOccurrences(of: "&#x26;", with: "&")
	.replacingOccurrences(of: "&#x3C;", with: "<")
	.replacingOccurrences(of: "&#x3E;", with: ">")
	.replacingOccurrences(of: "&#x27;", with: "'")
	.replacingOccurrences(of: "&#x22;", with: "\"")
)

/*:
Or you may use power of NSAttributedString, but please read carefully about performance problems and limitations [here](https://developer.apple.com/documentation/foundation/nsattributedstring/1524613-init).
*/

let data = xmlString.data(using: .utf8)!
let attributedString = try NSAttributedString(
	data: data,
	options: [.documentType: NSAttributedString.DocumentType.html],
	documentAttributes: nil
)
print(attributedString.string)

/*:
Or you may use powers of ICU transforms:
*/

print(xmlString.transformed(with: "Hex/XML", reverse: true))

//: [Next](@next)
