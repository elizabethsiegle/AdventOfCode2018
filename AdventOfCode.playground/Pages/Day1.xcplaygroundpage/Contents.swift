//: [Previous](@previous)

import Foundation

//part one
var freqs: [Int] = []
let filePath = Bundle.main.path(forResource:"input", ofType: "txt") //get file from Resources
let data = FileManager.default.contents(atPath: filePath!)
let content = String(data: data!, encoding: .utf8)!
var cleanArr = content.split(separator: "\n").map { Int($0)!} //convert to int
//print(cleanArr)
let totalSum = cleanArr.reduce(0, +) //sum
print("Sum of array in part 1: \(totalSum)")


//part 2
var currFreq = 0
var freqsSeen = Set<Int>([currFreq])

var ind = 0
while true {
    let change = cleanArr[ind]
    currFreq += change
    if !freqsSeen.insert(currFreq).inserted {
        print("First duplicate in part 2: \(currFreq)")
        break
    }
    ind = (ind + 1) % cleanArr.count
}


//: [Next](@next)
