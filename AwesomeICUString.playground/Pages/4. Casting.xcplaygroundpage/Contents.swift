/*:
For upper and lower transform prefer using lowercased() and uppercased() functions in Swift.
Complexity of these operations are O(n).
You may find some intresting details [here](https://github.com/apple/swift/blob/master/stdlib/public/core/String.swift)
*/

import Foundation

print("иванов иван иванович".transformed(with: "Upper"))
print("иванов иван иванович".transformed(with: "Lower"))
print("иванов иван иванович".transformed(with: "[а] Upper"))
print("иванов иван иванович".transformed(with: "[а,о,и] Upper"))
print("иванов иван иванович".transformed(with: "[a-я] Upper"))
print("иванов иван иванович".transformed(with: "Title"))

var str = "Hello, playground"

//: [Next](@next)
