# Awesome Strings and ICU Transforms

Welcome to AwesomeICUString playground.

This playground shows the power of [ICU](http://site.icu-project.org/) transformations using `String.applyingTransform` function
and explains some keypoints about `String` characteristics and representations.

You'll learn about transliterating, casing, filtering and encoding strings using powers of ICU transforms like:
```swift
print("иванов иван иванович".transformed(with: "Latin"))
// prints ivanov ivan ivanovič

print("иванов иван иванович".transformed(with: "Title"))
// prints Иванов Иван Иванович

print("Hi Guys!😀".transformed(with: "[:Emoji:] Remove"))
// prints Hi Guys

let xmlEncodedString = "&#x26;&#x3C;&#x3E;&#x27;&#x22;"
print(xmlEncodedString.transformed(with: "Hex/XML", reverse: true))
// prints &<>'"
```


For more info just open the `AwesomeICUString.playground` file.
