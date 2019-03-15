
/*
 Welcome to AwesomeICUString playground.
 This playground shows the power of ICU transformations using String.applyingTransform function
 and explains some keypoints about String characteristics and representations.

 See more:
 1. http://site.icu-project.org/
 2. https://oleb.net/blog/2016/01/icu-text-transforms/
 3. https://nshipster.com/cfstringtransform/
 4. https://dev.mikamai.com/2015/07/08/full-string-power-with-cfstringtransform/
 5. https://unicode.org/reports/tr44/#General_Category_Values
 6. https://github.com/apple/swift/blob/master/stdlib/public/core/String.swift
 7. https://developer.apple.com/documentation/foundation/nsstring/1407787-applyingtransform
*/

import UIKit

// String is a collection of Characters.
let flag = "🇷🇺"
print(flag.count)
print(Array(flag).count)

// String equality is based on equality of its Unicode sequences.

print("\u{1F30D}" == "🌍")

// Strings also have different representations or sequences of UnicodeScalarView.
// Length of the string depends on the chosen encoding.
// Prefer using flag.isEmpty instead of flag.count == 0.
// You may see more in https://github.com/apple/swift/blob/master/stdlib/public/core/String.swift.

print(flag.unicodeScalars.count)
print(flag.utf16.count)
print(flag.utf8.count)




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// ICU transforms via String.applyingTransform
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// Many string and unicode transformations use ICU on the low level. iOS system includes libICU.
// You may use some ICU (http://site.icu-project.org/) transforms via String.applyingTransform.

if let transcriptesString = "матрёшка".applyingTransform(.toLatin, reverse: false) {
	print(transcriptesString)
	print(transcriptesString.applyingTransform(.stripDiacritics, reverse: false) ?? transcriptesString)
}
print("🌍".applyingTransform(.toUnicodeName, reverse: false) ?? "🌍")

// There are 16 standart transforms, but there are many others if you just create your own rule
// according to the ICU standart.
// Let's add the category below for demonstating true power of ICU transforms.

extension String {
	func transformed(with rule: String, reverse: Bool = false) -> String {
		return self.applyingTransform(StringTransform(rawValue: rule), reverse: reverse) ?? self
	}
}




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Transliteration
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// You may try differenet transforms using online converter on ICU site: http://demo.icu-project.org/icu-bin/translit

print("иванов иван иванович".applyingTransform(.toLatin, reverse: false) ?? "none")
print("Ivan Ivanov".applyingTransform(.latinToKatakana, reverse: false) ?? "none")

print("иванов иван иванович".transformed(with: "Latin"))
print("ртищев евгений сергеевич".transformed(with: "Latin"))
print("ртищев евгений сергеевич".transformed(with: "ru-ru_Latn/BGN"))

let rule = "::[ЁА-яё]; [аеиоуыэ-яё]{ы} > ·y; [ЁАЕИОУЫЭ-Я]{[Ыы]} > ·Y; [[[[:Uppercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]][[:Lowercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]]]-[Йй]]{Э} > ·E; [[[[:Uppercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]][[:Lowercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]]]-[Йй]]{э} > ·e; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Е}[:Uppercase:] > YE; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Е} > Ye; [[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё][ЙЪЬйъь]]{е} > ye; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Ё}[:Uppercase:] > YË; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Ё} > Yë; [[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё][ЙЪЬйъь]]{ё} > yë; ::Null; А > A; а > a; Б > B; б > b; В > V; в > v; Г > G; г > g; Д > D; д > d; [^[:L:][:M:][:N:]]{Е}[:Uppercase:] > YE; [^[:L:][:M:][:N:]]{Е} > Ye; Е > E; [^[:L:][:M:][:N:]]{е} > ye; е > e; [^[:L:][:M:][:N:]]{Ё}[:Uppercase:] > YË; [^[:L:][:M:][:N:]]{Ё}[:Lowercase:] > Yë; Ё > Ë; [^[:L:][:M:][:N:]]{ё} > yë; ё > ë; {Ж}[:Lowercase:] > Zh; Ж > ZH; ж > zh; З > Z; з > z; И > I; и > i; {Й}[АУЫЭауыэ] > Y·; {й}[АУЫЭауыэ] > y·; Й > Y; й > y; К > K; к > k; Л > L; л > l; М > M; м > m; Н > N; н > n; О > O; о > o; П > P; п > p; Р > R; р > r; С > S; с > s; ТС > T·S; Тс > T·s; тс > t·s; Т > T; т > t; У > U; у > u; Ф > F; ф > f; {Х}[:Lowercase:] > Kh; Х > KH; х > kh; {Ц}[:Lowercase:] > Ts; Ц > TS; ц > ts; {Ч}[:Lowercase:] > Ch; Ч > CH; ч > ch; ШЧ > SH·CH; Шч > Sh·ch; шч > sh·ch; {Ш}[:Lowercase:] > Sh; Ш > SH; ш > sh; {Щ}[:Lowercase:] > Shch; Щ > SHCH; щ > shch; Ъ > ʺ; ъ > ʺ; {Ы}[АУЫЭауыэ] > Y·; {ы}[ауыэ] > y·; Ы > Y; ы > y; Ь > ʹ; ь > ʹ; Э > E; э > e; {Ю}[:Lowercase:] > Yu; Ю > YU; ю > yu; {Я}[:Lowercase:] > Ya; Я > YA; я > ya;"

print("ртищев евгений сергеевич".transformed(with: rule))




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Casing
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// For upper and lower transform prefer using lowercased() and uppercased() functions in Swift.
// Complexity of these operations are O(n).
// You may find some intresting details here: https://github.com/apple/swift/blob/master/stdlib/public/core/String.swift

print("иванов иван иванович".transformed(with: "Upper"))
print("иванов иван иванович".transformed(with: "Lower"))
print("иванов иван иванович".transformed(with: "[а] Upper"))
print("иванов иван иванович".transformed(with: "[а,о,и] Upper"))
print("иванов иван иванович".transformed(with: "[a-я] Upper"))
print("иванов иван иванович".transformed(with: "Title"))




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Normalization
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// Please read some article or Wiki about string normalization to understand meanings of composition (NFC)
// and decomposition (NFD). Normalization is often used in web to create spam filters.

print("é".transformed(with: "NFD; Hex/Unicode"))
print("e".transformed(with: "NFD; Hex/Unicode"))
print("2⁸".transformed(with: "NFKC;"))
print("👍🏿".transformed(with: "NFD; Hex/Unicode"))



// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Filtering
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// Here goes some list of keys you may use inside your transforms:
// * [:Letter:]
// * [:Number:]
// * [:Punctuation:]
// * [:Whitespace:]
// * [:Symbol:]
// * [:Math:]
// * [:Emoji:]

print("Мне очень понравился фильм:-))!!".transformed(with: "[:Punctuation:] Remove"))
print("1+1 Intouchables".transformed(with: "[:Letter:] Remove"))
print("Привет! 😀".transformed(with: "[:Emoji:] Remove"))

// It's really amazing but ICU transforms understand that ↉ and ⅚ are numbers.

let stringWithDigits = "начало1234567890↉⅚конец"
print(stringWithDigits.transformed(with: "[:Number:] Remove"))
print(stringWithDigits.components(separatedBy: CharacterSet.decimalDigits).joined())




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Encoding
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// You've definetely had this problem if you worked with XML data from backend.
// You received an encoded string and need to get the non-escaped symbols.
// There are 5 special XML characters: &<>'"

let xmlString = "&#x26;&#x3C;&#x3E;&#x27;&#x22;"

// You may use code like that:

print(xmlString
	.replacingOccurrences(of: "&#x26;", with: "&")
	.replacingOccurrences(of: "&#x3C;", with: "<")
	.replacingOccurrences(of: "&#x3E;", with: ">")
	.replacingOccurrences(of: "&#x27;", with: "'")
	.replacingOccurrences(of: "&#x22;", with: "\"")
)

// Or you may use power of NSAttributedString, but please read carefully about performance problems and limitations:
// https://developer.apple.com/documentation/foundation/nsattributedstring/1524613-init

let data = xmlString.data(using: .utf8)!
let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
print(attributedString.string)

// Or you may use powers of ICU transforms:

print(xmlString.transformed(with: "Hex/XML", reverse: true))




// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Afterwords
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// I hope you've enjoyed working with AwesomeICUString playground.
// If you find any new and cool tranforms or you have questions you may write me back:
// LinkedIn: https://www.linkedin.com/in/evgenii-rtishchev-902bb44b/
// Telegram: katleta3000
