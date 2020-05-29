//: Playground - noun: a place where people can play

import UIKit

var test: String?
test = "alguma coisa"

if let test = test {
    print(test)
}
else {
    print("nada")
}

var test2 = test ?? "nada"
print(test2)

var test3 = test == "alguma coisa" ? "sim" : "não"
print(test3)

func soma(valor1: Int, valor2: Int) -> Int {
    return valor1 + valor2
}

soma(valor1: 1, valor2: 2)

