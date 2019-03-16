import UIKit

/*:
String is a collection of Characters.
*/
let flag = "🇷🇺"
print(flag.count)
print(Array(flag).count)

/*:
String equality is based on equality of its Unicode sequences.
*/

print("\u{1F30D}" == "🌍")

/*:
 Strings also have different representations or sequences of UnicodeScalarView.
 Length of the string depends on the chosen encoding.
 Prefer using flag.isEmpty instead of flag.count == 0.
 You may see more in https://github.com/apple/swift/blob/master/stdlib/public/core/String.swift.
*/
print(flag.unicodeScalars.count)
print(flag.utf16.count)
print(flag.utf8.count)
