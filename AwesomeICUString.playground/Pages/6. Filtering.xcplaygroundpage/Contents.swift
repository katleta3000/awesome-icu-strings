import Foundation

/*:
Here goes some list of keys you may use inside your transforms:
* [:Letter:]
* [:Number:]
* [:Punctuation:]
* [:Whitespace:]
* [:Symbol:]
* [:Math:]
* [:Emoji:]
*/

print("Мне очень понравился фильм:-))!!".transformed(with: "[:Punctuation:] Remove"))
print("1+1 Intouchables".transformed(with: "[:Letter:] Remove"))
print("Привет! 😀".transformed(with: "[:Emoji:] Remove"))

/*:
It's really amazing but ICU transforms understand that ↉ and ⅚ are numbers.
*/

let stringWithDigits = "начало1234567890↉⅚конец"
print(stringWithDigits.transformed(with: "[:Number:] Remove"))
print(stringWithDigits.components(separatedBy: CharacterSet.decimalDigits).joined())

//: [Next](@next)
