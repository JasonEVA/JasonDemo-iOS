//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print("nihao")

var expleam:Float = 40

expleam = 33

let label = "The width is"

let wdth = 94

let widthLable = label + String(wdth)


var shoppingList = ["1","2","3"]
print(shoppingList)
var dict = ["xing":"wang","ming":"zhe"]
dict["sex"] = "nan"
print(dict)

let empty = [String:Double]()

let individScores = [72,46,55,74,88,33]

var teamScore = 0

for score in individScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore -= 2
    }
}
print(teamScore)

var optionalString:String? = "hello"
print(optionalString == nil)

var optionalName:String? = "Jason"
var greeting:String? = "hi"
if let namt = optionalName {
    greeting = "hello,\(namt)"
} else {
    greeting = "wang"
}


let nikeName:String? = nil
let fullName:String? = "JasonWang"
let informalGreeting = "Hi, \(nikeName ?? fullName)"

print(informalGreeting)

let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisions")
    case "cucumber":
    print("That would")
case let x where x.hasSuffix("pepper"):
    print("is it a spicy \(x)?")
default:
    print("everything right")
}

let interestingNumbers = ["Prime":[2,3,5,7,9,11,13],"Fibonacci":[1,1,2,3,5,8],"Square":[1,4,9,15,25]]

var largest = 0
var largestName:String? = nil

for (kind,numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestName = kind;
        }
    }
}

print(largest,largestName ?? "123")


var n = 2

while n < 100 {
    n = n * 2
}

print(n)


var m = 2

repeat {
    m = m * 2
} while m < 100
print(m)


var total = 0
for i in 0..<4 {
    total += i
}
print(total)

func greet (_ person:String,on day:String,eat:String) ->String {
    return "hello \(person),today is \(day) \(eat)"
}

greet( "Jason", on: "Tuesday",eat: "123")

print(greet( "Jason", on: "Tuesday",eat: "123"))


func calculateStatisics(scores:[Int]) -> (min:Int,max:Int,sum:Int) {
    var min1 = scores[0]
    var max1 = scores[0]
    var sum1 = 0
    
    for score in scores {
        if score > max1 {
            max1 = score
        } else if score < min1 {
            min1 = score
        }
        sum1 += score
    }
    
    return (min1,max1,sum1)
    
}

let  statistics = calculateStatisics(scores: [5,3,100,3,9])
print(statistics.sum)
print(calculateStatisics(scores: [5,3,100,3,9]).1)

func sumOf(numbers:Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
    
}

print(sumOf(numbers: 1,2,2,2))

func average(numbers:Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum / numbers.count
}

print(average(numbers: 1,3,5,7,1))

func returnFifteen() -> Int {
    var y = 10
    
    func add() {
        y += 5
    }
    add()
    return y;
    
}
print(returnFifteen())

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

var increment  = makeIncrementer()

increment(89)

func hasAnyMatches(list:[Int],condition:(Int) -> Bool) {
    for item in list {
        if condition(item) {
            print(true)
        }
    }
    print(false)
}


func lessThanTen(number:Int) -> Bool {
    return number < 10
}

var numbers = [20,19,7,12]

hasAnyMatches(list: numbers, condition: lessThanTen)


numbers.map ({ (number:Int) -> Int in
    let result = 3 * number
    return result
})

let mappedNumbers = numbers.map({number in 3 * number})

print(mappedNumbers)


