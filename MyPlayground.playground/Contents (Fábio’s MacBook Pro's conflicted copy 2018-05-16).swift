//: Playground - noun: a place where people can play

import UIKit


// Guard
func guardTest(x: Int?) {
	defer {
		print("saiu")
	}
	
	guard let x = x, x > 5 else {
		print("lesser")
		return
	}
	
	print(x)
}


guardTest(x: 5)

var cars = ["208", "Fiesta", "HB20", "Fit"]

for car in cars {
	guard car == "208" else {
		continue
	}
	
	
	print(car)
}

// Inline if
let testValue = 10

// Ternary
let message = testValue < 5 ? "lesser" : "greater"

// min/  max
print(Int.max)
print(Int.min)

print(UInt.max)
print(UInt.min)

// Tuples
var errorCode = (code: 404, error: "not found")

print(errorCode.code)

var errorArray: [(code: Int, error: String)] = []

errorArray.append(errorCode)
errorArray.append((code: 301, error: "redirect"))

print(errorArray)

var myInt = 0

for i in 1...5 {
	myInt += 1
	
	print(myInt)
}

// For case
for case let error in errorArray where error.code == 404 {
	print(error)
}

// Optional if
var errorDescription: String?

let description = errorDescription ?? "no error"

// Default parameters
func logTexts (withText text: String..., andPunctuation punct: String = "."){
	for t in text {
		print("\(t) \(punct)")
	}
}

logTexts(withText: "hello")
logTexts(withText: "hello", "olá", andPunctuation: "!")
logTexts(withText: "hello", andPunctuation: "!")

// multiple function's return
func returnNumbers() -> (evens: [Int], odds: [Int]) {
	var evens = [Int]()
	var odds = [Int]()
	
	for i in 1...100 {
		if i % 2 == 0 {
			evens.append(i)
		}
		else{
			odds.append(i)
		}
	}
	
	return (evens, odds)
}

returnNumbers()

// closure capture values
func makeGrowthTracker(forGrowth growth: Int) -> () -> Int {
	var totalGrowth = 0
	func growthTracker() -> Int {
		totalGrowth += growth
		return totalGrowth
	}
	
	return growthTracker
}

var currentPopulation = 5000
let growBy500 = makeGrowthTracker(forGrowth: 500)
growBy500()
growBy500()
currentPopulation += growBy500()



