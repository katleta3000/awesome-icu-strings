//: [Previous](@previous)

import Foundation

/*:
You may try differenet transforms using online converter on ICU site: http://demo.icu-project.org/icu-bin/translit
*/

print("иванов иван иванович".applyingTransform(.toLatin, reverse: false) ?? "none")
print("Ivan Ivanov".applyingTransform(.latinToKatakana, reverse: false) ?? "none")

print("иванов иван иванович".transformed(with: "Latin"))
print("ртищев евгений сергеевич".transformed(with: "Latin"))
print("ртищев евгений сергеевич".transformed(with: "ru-ru_Latn/BGN"))

let rule = "::[ЁА-яё]; [аеиоуыэ-яё]{ы} > ·y; [ЁАЕИОУЫЭ-Я]{[Ыы]} > ·Y; [[[[:Uppercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]][[:Lowercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]]]-[Йй]]{Э} > ·E; [[[[:Uppercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]][[:Lowercase:]-[[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё]]]]-[Йй]]{э} > ·e; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Е}[:Uppercase:] > YE; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Е} > Ye; [[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё][ЙЪЬйъь]]{е} > ye; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Ё}[:Uppercase:] > YË; [[ЁАЕИОУЫЭ-Я][ЙЪЬ]]{Ё} > Yë; [[ЁАЕИОУЫЭ-Я][аеиоуыэ-яё][ЙЪЬйъь]]{ё} > yë; ::Null; А > A; а > a; Б > B; б > b; В > V; в > v; Г > G; г > g; Д > D; д > d; [^[:L:][:M:][:N:]]{Е}[:Uppercase:] > YE; [^[:L:][:M:][:N:]]{Е} > Ye; Е > E; [^[:L:][:M:][:N:]]{е} > ye; е > e; [^[:L:][:M:][:N:]]{Ё}[:Uppercase:] > YË; [^[:L:][:M:][:N:]]{Ё}[:Lowercase:] > Yë; Ё > Ë; [^[:L:][:M:][:N:]]{ё} > yë; ё > ë; {Ж}[:Lowercase:] > Zh; Ж > ZH; ж > zh; З > Z; з > z; И > I; и > i; {Й}[АУЫЭауыэ] > Y·; {й}[АУЫЭауыэ] > y·; Й > Y; й > y; К > K; к > k; Л > L; л > l; М > M; м > m; Н > N; н > n; О > O; о > o; П > P; п > p; Р > R; р > r; С > S; с > s; ТС > T·S; Тс > T·s; тс > t·s; Т > T; т > t; У > U; у > u; Ф > F; ф > f; {Х}[:Lowercase:] > Kh; Х > KH; х > kh; {Ц}[:Lowercase:] > Ts; Ц > TS; ц > ts; {Ч}[:Lowercase:] > Ch; Ч > CH; ч > ch; ШЧ > SH·CH; Шч > Sh·ch; шч > sh·ch; {Ш}[:Lowercase:] > Sh; Ш > SH; ш > sh; {Щ}[:Lowercase:] > Shch; Щ > SHCH; щ > shch; Ъ > ʺ; ъ > ʺ; {Ы}[АУЫЭауыэ] > Y·; {ы}[ауыэ] > y·; Ы > Y; ы > y; Ь > ʹ; ь > ʹ; Э > E; э > e; {Ю}[:Lowercase:] > Yu; Ю > YU; ю > yu; {Я}[:Lowercase:] > Ya; Я > YA; я > ya;"

print("ртищев евгений сергеевич".transformed(with: rule))

//: [Next](@next)
