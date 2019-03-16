//: [Previous](@previous)

import Foundation

/*:
Please read some article or Wiki about string normalization to understand meanings of composition (NFC) and decomposition (NFD). Normalization is often used in web to create spam filters.
*/

print("é".transformed(with: "NFD; Hex/Unicode"))
print("e".transformed(with: "NFD; Hex/Unicode"))
print("2⁸".transformed(with: "NFKC;"))
print("👍🏿".transformed(with: "NFD; Hex/Unicode"))

//: [Next](@next)
