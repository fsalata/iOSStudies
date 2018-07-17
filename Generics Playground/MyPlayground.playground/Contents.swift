//func addInts(x: Int, y: Int) -> Int {
//    return x + y
//}
//
//let intSum = addInts(x: 1, y: 2)
//
//
//func addDoubles(x: Double, y: Double) -> Double {
//    return x + y
//}
//
//let doubleSum = addDoubles(x: 1.0, y: 2.0)

struct Queue<Element: Equatable> {
    fileprivate var elements: [Element] = []
    
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}

var q = Queue<Int>()

q.enqueue(newElement: 4)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()

extension Queue {
    func peek() -> Element? {
        return elements.first
    }
}

q.enqueue(newElement: 5)
q.enqueue(newElement: 3)
q.peek()

extension Queue {
    func isHomogeneous() -> Bool {
        guard let first = elements.first else { return true }
        return !elements.contains { $0 != first }
    }
    
}
var h = Queue<Int>()
h.enqueue(newElement: 4)
h.enqueue(newElement: 4)
h.isHomogeneous()
h.enqueue(newElement: 2)
h.isHomogeneous()

func pairs<Key, Value>(from dictionary: [Key: Value]) -> [(Key, Value)] {
    return Array(dictionary)
}

func mid<T: Comparable>(array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.sorted()[(array.count - 1) / 2]
}

mid(array: [3, 5, 1, 2, 4])

protocol Summable { static func +(lhs: Self, rhs: Self) -> Self }
extension Int: Summable {}
extension Double: Summable {}

func add<T: Summable>(x: T, y: T) -> T {
    return x + y
}

let addIntSum = add(x: 1, y: 2)
let addDoubleSum = add(x: 1.0, y: 2.0)

extension String: Summable {}
let addString = add(x: "Generics", y: " are Awesome!!! :]")


enum MathError: Error {
    case divisionByZero
}

enum Result<Value> {
    case success(Value), failure(Error)
}

func divide(_ x: Int, by y: Int) -> Result<Int> {
    guard y != 0 else {
        return .failure(MathError.divisionByZero)
    }
    return .success(x / y)
}

let result1 = divide(42, by: 2)
let result2 = divide(42, by: 0)
