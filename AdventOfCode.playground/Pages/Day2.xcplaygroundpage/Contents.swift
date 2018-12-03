//: [Previous](@previous)

import Foundation

//part one

//copied and pasted from day1 lol
var freqs: [Int] = []
let filePath = Bundle.main.path(forResource:"input", ofType: "txt") //get file from Resources
let data = FileManager.default.contents(atPath: filePath!)
let content = String(data: data!, encoding: .utf8)!
var cleanArr = content.split(separator: "\n")

//new
var twos = 0, threes = 0 //init as 0, will increment based on what is in each line
cleanArr.forEach { el in //loop through each line in data .txt file
    let mappedItems = el.map { ($0, 1) } //key/val pair with character and # 1 (will be incremented)
    let counts = Dictionary(mappedItems, uniquingKeysWith: +) //key = character, value = adds the 1's together whenever a duplicate is found
    print(counts)
    if counts.contains(where: { $0.value == 2 }) {
        twos += 1
    }
    if counts.contains(where: { $0.value == 3 }) {
        threes += 1
    }
}

print("\(twos * threes)")

//part 2
var diff = [(Character, Character)]()
var res: String = ""

// Iterate through all possible key combos
cleanArr.forEach { el in
    cleanArr.forEach {
        el2 in
        diff = zip(el, el2).filter { $0 != $1 }
        if diff.count == 1 {
            diff = zip(el, el2).filter { $0 == $1 } //common
            for (char, _) in diff {
                //add to string
                res += String(char)
            }
            print(res)
            exit(1)
        }
    }
}

//: [Next](@next)
